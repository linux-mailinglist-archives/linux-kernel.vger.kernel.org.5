Return-Path: <linux-kernel+bounces-21886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829FF82960A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B4F1F22586
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37EB3E49B;
	Wed, 10 Jan 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jwzagr8r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234082E846;
	Wed, 10 Jan 2024 09:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47841C433C7;
	Wed, 10 Jan 2024 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704878137;
	bh=ahio7T25Z11avb9NbE7tOGh6X6/776n8O1/ownXKe10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwzagr8rUcwaOjiUjF3gbJ54Tl1s+O9RpmfCsYDue3E1YUowoTRPX4cEtYJx5qD3A
	 j3seAQxKPwmyfv7lVKhWRyVHLJDQbaCvNX3qlFkXQ4ZlaUX+508N/MjNy2+wlVaLNZ
	 sekmwa4NU2A+KjyNUmrzeFCzV3zXtL0W28NJP2NU=
Date: Wed, 10 Jan 2024 10:15:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Pavel Machek <pavel@ucw.cz>, bvanassche@acm.org, hch@lst.de,
	hare@suse.de, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	stable@vger.kernel.org, lwn@lwn.net, jslaby@suse.cz
Subject: Re: scsi_get_lba breakage in 5.10 -- Re: Linux 5.10.206
Message-ID: <2024011047-clench-scheme-1f46@gregkh>
References: <2024010527-revision-ended-aea2@gregkh>
 <ZZ042FejzwMM5vDW@duo.ucw.cz>
 <yq1jzoi7hrt.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1jzoi7hrt.fsf@ca-mkp.ca.oracle.com>

On Tue, Jan 09, 2024 at 08:55:52AM -0500, Martin K. Petersen wrote:
> 
> Pavel,
> 
> > This is bad idea. This changes return value, but without fixing
> > callers; there will be subtle bugs somewhere.
> 
> I'm not sure why this particular change was backported since it was part
> of a larger cleanup of explicitly distinguishing between block layer
> sectors and device-specific LBAs. This was done to fix devices using PI
> with 4 KB blocks which would otherwise end up getting programmed with
> the wrong reference tag value.
> 
> > At minimum, we need this:
> >
> > 87662a472a9d8980b26ba5803447df2c4981d467 scsi: iser: Use scsi_get_sector() instead of scsi_get_lba()
> 
> I agree this would be appropriate. Otherwise we'll print the error being
> at the wrong sector in case of an error on a PI device with 4 KB blocks.
> However, the message is purely informative.
> 
> > That will fix iser, but there's also:
> >
> > drivers/s390/scsi/zfcp_fsf.c:           io->ref_tag_value = scsi_get_lba(scsi_cmnd) & 0xFFFFFFFF;
> > drivers/scsi/isci/request.c:            tc->ref_tag_seed_gen = scsi_get_lba(scmd) & 0xffffffff;
> > drivers/scsi/isci/request.c:            tc->ref_tag_seed_verify = scsi_get_lba(scmd) & 0xffffffff;
> > drivers/scsi/lpfc/lpfc_scsi.c:  lba = scsi_get_lba(sc);
> > drivers/scsi/lpfc/lpfc_scsi.c:  reftag = (uint32_t)scsi_get_lba(sc); /* Truncate LBA */
> > drivers/scsi/lpfc/lpfc_scsi.c:  reftag = (uint32_t)scsi_get_lba(sc); /* Truncate LBA */
> > drivers/scsi/lpfc/lpfc_scsi.c:  reftag = (uint32_t)scsi_get_lba(sc); /* Truncate LBA */
> > drivers/scsi/lpfc/lpfc_scsi.c:  reftag = (uint32_t)scsi_get_lba(sc); /* Truncate LBA */
> > drivers/scsi/lpfc/lpfc_scsi.c:          start_ref_tag = (uint32_t)scsi_get_lba(cmd); /* Truncate LBA */
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:          failing_sector = scsi_get_lba(cmd);
> > drivers/scsi/lpfc/lpfc_scsi.c:                          (unsigned long long)scsi_get_lba(cmd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                                   (unsigned long long)scsi_get_lba(cmnd),
> > drivers/scsi/lpfc/lpfc_scsi.c:                                   (unsigned long long)scsi_get_lba(cmnd),
> > drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_lba(cmd)));
> > drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_lba(cmd)));
> > drivers/scsi/qla2xxx/qla_iocb.c:                    (0xffffffff & scsi_get_lba(cmd)));
> > drivers/scsi/qla2xxx/qla_isr.c:     cmd->cmnd[0], (u64)scsi_get_lba(cmd), a_ref_tag, e_ref_tag,
> > drivers/scsi/qla2xxx/qla_isr.c:         sector_t lba_s = scsi_get_lba(cmd);
> 
> Save for two cases in lpfc_queuecommand (which like the iser case will
> print the wrong sector number on error) all these look OK to me. Note
> that almost all callers of scsi_get_lba() actually intended to get the
> protocol LBA as the name indicates and not the block layer sector
> number.

Ick, this is going to get complex fast.  How about I revert the whole
series, and then just add the one bugfix at the end, in a "fixed by
hand" version like I have here below.  Would that be better overall?

Thanks,

greg k-h


diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 0c4bc42b55c2..3d3d139127ee 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1069,6 +1069,7 @@ static int scsi_send_eh_cmnd(struct scsi_cmnd *scmd, unsigned char *cmnd,
 
 	scsi_log_send(scmd);
 	scmd->scsi_done = scsi_eh_done;
+	scmd->flags |= SCMD_LAST;
 
 	/*
 	 * Lock sdev->state_mutex to avoid that scsi_device_quiesce() can
@@ -2361,6 +2362,7 @@ scsi_ioctl_reset(struct scsi_device *dev, int __user *arg)
 	scsi_init_command(dev, scmd);
 	scmd->request = rq;
 	scmd->cmnd = scsi_req(rq)->cmd;
+	scmd->flags |= SCMD_LAST;
 
 	scmd->scsi_done		= scsi_reset_provider_done_command;
 	memset(&scmd->sdb, 0, sizeof(scmd->sdb));

