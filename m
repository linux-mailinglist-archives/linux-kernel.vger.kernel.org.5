Return-Path: <linux-kernel+bounces-8212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3A81B3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DB228243A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF669299;
	Thu, 21 Dec 2023 10:35:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6D6978E;
	Thu, 21 Dec 2023 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAA052F4;
	Thu, 21 Dec 2023 02:36:18 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05D2E3F5A1;
	Thu, 21 Dec 2023 02:35:32 -0800 (PST)
Date: Thu, 21 Dec 2023 10:35:30 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Xinglong Yang <xinglong.yang@cixtech.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: Check Mailbox/SMT channel for
 consistency
Message-ID: <ZYQU8n7btB17nvuc@pluto>
References: <20231220172112.763539-1-cristian.marussi@arm.com>
 <PUZPR06MB54988A8170D462FC8EE43A05F095A@PUZPR06MB5498.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR06MB54988A8170D462FC8EE43A05F095A@PUZPR06MB5498.apcprd06.prod.outlook.com>

On Thu, Dec 21, 2023 at 10:31:29AM +0000, Xinglong Yang wrote:
> Hi, Cristian
> 
> This patch successfully solves the bug.
> 

Hi Xinglong,

thanks for reporting and testing !

Cristian

> From: Cristian Marussi <cristian.marussi@arm.com> Sent: Thursday, December 21, 2023 1:21 AM
> > On reception of a completion interrupt the SMT memory area is accessed to
> > retrieve the message header at first and then, if the message sequence
> > number identifies a transaction which is still pending, the related
> > payload is fetched too.
> >
> > When an SCMI command times out the channel ownership remains with the
> > platform until eventually a late reply is received and, as a consequence,
> > any further transmission attempt remains pending, waiting for the channel
> > to be relinquished by the platform.
> >
> > Once that late reply is received the channel ownership is given back
> > to the agent and any pending request is then allowed to proceed and
> > overwrite the SMT area of the just delivered late reply; then the wait for
> > the reply to the new request starts.
> >
> > It has been observed that the spurious IRQ related to the late reply can
> > be wrongly associated with the freshly enqueued request: when that
> > happens
> > the SCMI stack in-flight lookup procedure is fooled by the fact that the
> > message header now present in the SMT area is related to the new pending
> > transaction, even though the real reply has still to arrive.
> >
> > This race-condition on the A2P channel can be detected by looking at the
> > channel status bits: a genuine reply from the platform will have set the
> > channel free bit before triggering the completion IRQ.
> >
> > Add a consistency check to validate such condition in the A2P ISR.
> >
> > Reported-by: Xinglong Yang <xinglong.yang@cixtech.com>
> > Closes:
> > https://lore.k/
> > ernel.org%2Fall%2FPUZPR06MB54981E6FA00D82BFDBB864FBF08DA%40PUZP
> > R06MB5498.apcprd06.prod.outlook.com%2F&data=05%7C02%7Cxinglong.ya
> > ng%40cixtech.com%7C669e9ff5e6764a77791208dc01801b8e%7C0409f77ae53
> > d4d23943eccade7cb4811%7C1%7C0%7C638386896955072826%7CUnknown%
> > 7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> > wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=T1DOD7KfY%2FJNJHacHtX
> > d5wcfde%2Fd5UDqGvyW4vuYwYU%3D&reserved=0
> > Fixes: 5c8a47a5a91d ("firmware: arm_scmi: Make scmi core independent of
> > the transport type")
> > CC: stable@vger.kernel.org # 5.15+
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/common.h  |  1 +
> >  drivers/firmware/arm_scmi/mailbox.c | 14 ++++++++++++++
> >  drivers/firmware/arm_scmi/shmem.c   |  6 ++++++
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/drivers/firmware/arm_scmi/common.h
> > b/drivers/firmware/arm_scmi/common.h
> > index 3b7c68a11fd0..0956c2443840 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -329,6 +329,7 @@ void shmem_fetch_notification(struct
> > scmi_shared_mem __iomem *shmem,
> >  void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
> >  bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
> >                      struct scmi_xfer *xfer);
> > +bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem);
> >
> >  /* declarations for message passing transports */
> >  struct scmi_msg_payld;
> > diff --git a/drivers/firmware/arm_scmi/mailbox.c
> > b/drivers/firmware/arm_scmi/mailbox.c
> > index 19246ed1f01f..b8d470417e8f 100644
> > --- a/drivers/firmware/arm_scmi/mailbox.c
> > +++ b/drivers/firmware/arm_scmi/mailbox.c
> > @@ -45,6 +45,20 @@ static void rx_callback(struct mbox_client *cl, void *m)
> >  {
> >         struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
> >
> > +       /*
> > +        * An A2P IRQ is NOT valid when received while the platform still has
> > +        * the ownership of the channel, because the platform at first releases
> > +        * the SMT channel and then sends the completion interrupt.
> > +        *
> > +        * This addresses a possible race condition in which a spurious IRQ from
> > +        * a previous timed-out reply which arrived late could be wrongly
> > +        * associated with the next pending transaction.
> > +        */
> > +       if (cl->knows_txdone && !shmem_channel_free(smbox->shmem)) {
> > +               dev_warn(smbox->cinfo->dev, "Ignoring spurious A2P IRQ !\n");
> > +               return;
> > +       }
> > +
> >         scmi_rx_callback(smbox->cinfo, shmem_read_header(smbox->shmem),
> > NULL);
> >  }
> >
> > diff --git a/drivers/firmware/arm_scmi/shmem.c
> > b/drivers/firmware/arm_scmi/shmem.c
> > index 87b4f4d35f06..517d52fb3bcb 100644
> > --- a/drivers/firmware/arm_scmi/shmem.c
> > +++ b/drivers/firmware/arm_scmi/shmem.c
> > @@ -122,3 +122,9 @@ bool shmem_poll_done(struct scmi_shared_mem
> > __iomem *shmem,
> >                 (SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR |
> >                  SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
> >  }
> > +
> > +bool shmem_channel_free(struct scmi_shared_mem __iomem *shmem)
> > +{
> > +       return (ioread32(&shmem->channel_status) &
> > +                       SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
> > +}
> > --
> > 2.34.1
> 
> Thanks,
> Xinglong
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

