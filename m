Return-Path: <linux-kernel+bounces-40451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C383A83E0A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8101F21E05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8420B03;
	Fri, 26 Jan 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SPUi2GE1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92020319
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290994; cv=none; b=Pk4ZY7gK0AKsm9L2GTyufmTXihaG/ypNDQ40z9df2tJWSfIbTFJn9gkgL/MQWr/UhuPczX+NYBtNGs9EHWdDYfWgy3Xf3naOQrX4/ANrtqcJ0Z60JvLMAaYJrxSP2IiztR8xTgpgmV30JLBZGSiEsNtkuO3cHHwVBl2EzOX66pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290994; c=relaxed/simple;
	bh=SXylSozMIFvQcgeeHiv2u7d8n6Xr+YfeABQSd/Jah/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxqqBkJTULy+Hw4SJobq7qNnVKbDhdAYAeLkPkpPtjZfHc3h0FolsI/j3o4cLvnnjwAhuJt2rjsTla/WRzmKAUq2AW/OiFYyA3+mn85YIHQmRlxskixUD0PzkRup3L1DodBa5rIB4DxuLtQAH5fLmthlxUdu7KiBmEC70z5DsLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SPUi2GE1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso13700005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1706290991; x=1706895791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggkqhy1FEbzA5h/m9nSB2QSTIebzKmuAmAgA30UHV7c=;
        b=SPUi2GE1f34Gu8hYOAq6eKwv6nNIrcJlQPPX0gTyIwCcTdYwe+LrThmd3+pijcToeB
         XGkIbcOMzN9sfzTU1LPBNxDmZIKRMGPPTPPDWeJnFhvaNi61yPr3AWqN6R83qCQbW9Qi
         QQmKmPzmkV93Vf/ggQiLhmUshFCvUv2Ra93GuI/jq4X1jF+2T7uEp8s3km1y7nMBRH+Z
         +z3HCFTjqJKtqiv1GvT1J/nu1isqSOfN2DRI9FijjM16wHmzKDKRIFOn6VDEUgjp6tX9
         ID2YtmOLKY1lon2IcOINmUXdcpY3FrrjItANYw+T8MNxpH7G+ckn5g5ccQrgq99qzJ8u
         3dZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706290991; x=1706895791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggkqhy1FEbzA5h/m9nSB2QSTIebzKmuAmAgA30UHV7c=;
        b=q4eT+zD1wYSm+lsLKesBiK1z2Br2DO0TVUZgBzeG81mgSWZSTZjiwF2zJ0d6GxmumS
         2an4BdQrcp/ExprMN/sHVqR4wA8eRkoMa4Mzig5K4EYvTL62PZWVyCIv6aT2Jsb/IkUo
         ee0kTJSD+I3A8UYiqubkBevsZ/Q4QPYz7pjE3AVh4UxCG/AivWv15HmFfXmjHfm/9awb
         yLKMSC3qkep0IJYXul5P+macmpHrW7bRy9wTlOTOcoOrPrFNICYM3cMMz8iliMtmU54x
         ftWfHBSaR8qZDeRzaT99ajYpYjxzAuKyydc4ZjhrB8T5+GdkI4QNRUdknUFxyU/2A5jV
         MDfw==
X-Gm-Message-State: AOJu0Yy2pzE7uBhf3/lHErNiyU0ah75KNX30N5Q3AI0JgRgn/OvLqJ1x
	Wf3izOlQpV1vVfImFVKfQwY5CoVHRyd22AIxgGJ20gSWojiFHcBIHvqsyUKUxjT64i8eHadk/aC
	zl3kQNcYQlyY5/s16xNT0qVDW5FckhwrrCk47kQ==
X-Google-Smtp-Source: AGHT+IGymZGOhPiBKUQdsU+xfemOOTrCKN1ifGOHRfzo2kxHI0JiEurg0pV4VOJN2l1MG+o8Srz9ZjMpBoWYfzOBwbg=
X-Received: by 2002:a05:600c:3d91:b0:40e:5577:189 with SMTP id
 bi17-20020a05600c3d9100b0040e55770189mr66580wmb.147.1706290990772; Fri, 26
 Jan 2024 09:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701540918.git.lduncan@suse.com>
In-Reply-To: <cover.1701540918.git.lduncan@suse.com>
From: Lee Duncan <lduncan@suse.com>
Date: Fri, 26 Jan 2024 09:42:59 -0800
Message-ID: <CAPj3X_UWL8a3iXxA64bN5NDqWV2Try2-q84fYxaXk5uLCfGezQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] scsi: target: iscsi: Fix two protocol issues
To: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, dbond@suse.com, 
	hare@suse.de, cleech@redhat.com, michael.christie@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

I believe I've addressed Chris' issues. Chris?

On Sat, Dec 2, 2023 at 10:45=E2=80=AFAM lduncan@suse.com <lduncan@suse.com>=
 wrote:
>
> From: Lee Duncan <lduncan@suse.com>
>
> Recent boot testing using the fastlinq qedi iSCSI Converged Network
> Adapter and an LIO target uncovered a couple of issues with the
> kernel iSCSI target driver. The first patch addresses an issue
> with the handling of iSCSI "immediate commands", which are allowed
> but not common, and the second patch lowers the noise level of the
> driver when initiators send PDUs with the read and/or write bits
> set but no data, which is also allowed. (See RFC 3720)
>
> Lee Duncan (2):
>   scsi: target: iscsi: handle SCSI immediate commands
>   scsi: target: iscsi: don't warn of R/W when no data
>
>  drivers/target/iscsi/iscsi_target.c      | 17 ++++++-----------
>  drivers/target/iscsi/iscsi_target_util.c | 10 ++++++++--
>  2 files changed, 14 insertions(+), 13 deletions(-)
>
> --
> 2.43.0
>

