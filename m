Return-Path: <linux-kernel+bounces-20003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E7827819
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52FF285E54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879154FB1;
	Mon,  8 Jan 2024 19:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSFpIQbr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611B54F85;
	Mon,  8 Jan 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704740597; x=1736276597;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hotAzSDt4GyFBzV8LdqCM38AOqSNK8pRxPEhv/Fvg04=;
  b=HSFpIQbr8frpppMhT0QUzYZ8CV5RQVA9Fyj5bRmmPREGTjx8M8ZOvQWW
   KzgI4aH4+z1wt9Eqhi7OxViOzYIohHAULk8FCtBl6QN9NmQtzjelGLdDC
   jlU19qEuOwrpRHr9ePIkKfHpuGrl2VLntfP9hAQDztkGnCn3+BEUPtV+V
   NQEbVbQbp/bgyOMcveHlOmYbbMS6nAe4kYvmBXAMEOpdjEI4ll1qaVj+n
   oeevV7hUDY/17DBTFoqEGN0wCOZbwebSmcPu4e6EFrnX2QsdSRM/QCiPa
   fbyMJGAsSrq/3OXGqm8SvUnPKe20JLRff0PauJeJYfrPC6nTh1xvV9XEH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4757762"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="4757762"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 11:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1112814327"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="1112814327"
Received: from stinti-mobl.ger.corp.intel.com ([10.249.37.10])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 11:03:13 -0800
Date: Mon, 8 Jan 2024 21:03:06 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Liming Sun <limings@nvidia.com>
cc: Hans de Goede <hdegoede@redhat.com>, Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, Mark Gross <markgross@kernel.org>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] Drop Tx network packet when Tx TmFIFO is full
In-Reply-To: <BN9PR12MB50685E0F43D2C551B97326B0D36B2@BN9PR12MB5068.namprd12.prod.outlook.com>
Message-ID: <a5d02043-5654-acdb-e27e-23c792e12638@linux.intel.com>
References: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com> <02fd0faaa555d1914b6ff4bd4b0b294e16989cef.1704381197.git.limings@nvidia.com> <c510206b-1dbb-8f1-642d-7e1c8ac7a7c@linux.intel.com>
 <BN9PR12MB5068662A46D3B8A23BFE5DA6D3662@BN9PR12MB5068.namprd12.prod.outlook.com> <d5ce7c9f-eaf8-45d4-bb8b-24fb1153d946@redhat.com> <BN9PR12MB50685E0F43D2C551B97326B0D36B2@BN9PR12MB5068.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-974403408-1704740595=:1762"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-974403408-1704740595=:1762
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 8 Jan 2024, Liming Sun wrote:
> > -----Original Message-----
> > From: Hans de Goede <hdegoede@redhat.com>
> > Sent: Monday, January 8, 2024 9:23 AM
> > To: Liming Sun <limings@nvidia.com>; Ilpo Järvinen
> > <ilpo.jarvinen@linux.intel.com>
> > Cc: Vadim Pasternak <vadimp@nvidia.com>; David Thompson
> > <davthompson@nvidia.com>; Mark Gross <markgross@kernel.org>; Dan
> > Carpenter <dan.carpenter@linaro.org>; platform-driver-x86@vger.kernel.org;
> > LKML <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 1/1] Drop Tx network packet when Tx TmFIFO is full
> > 
> > Hi,
> > 
> > On 1/5/24 18:40, Liming Sun wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > >> Sent: Thursday, January 4, 2024 12:39 PM
> > >> To: Liming Sun <limings@nvidia.com>
> > >> Cc: Vadim Pasternak <vadimp@nvidia.com>; David Thompson
> > >> <davthompson@nvidia.com>; Hans de Goede <hdegoede@redhat.com>;
> > >> Mark Gross <markgross@kernel.org>; Dan Carpenter
> > >> <dan.carpenter@linaro.org>; platform-driver-x86@vger.kernel.org; LKML
> > >> <linux-kernel@vger.kernel.org>
> > >> Subject: Re: [PATCH v2 1/1] Drop Tx network packet when Tx TmFIFO is full
> > >>
> > >> On Thu, 4 Jan 2024, Liming Sun wrote:
> > >>
> > >>> Starting from Linux 5.16 kernel, Tx timeout mechanism was added
> > >>> into the virtio_net driver which prints the "Tx timeout" message
> > >>> when a packet is stuck in Tx queue for too long which could happen
> > >>> when external host driver is stuck or stopped and failed to read
> > >>> the FIFO.
> > >>>
> > >>> Below is an example of the reported message:
> > >>>
> > >>> "[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
> > >>> queue: 0, sq: output.0, vq: 0×1, name: output.0, usecs since
> > >>> last trans: 3079892256".
> > >>>
> > >>> To avoid such "Tx timeout" messages, this commit adds a timeout
> > >>> mechanism to drop and release the pending Tx packet if not able to
> > >>> transmit for two seconds due to Tx FIFO full.
> > >>>
> > >>> This commit also handles the special case that the packet is half-
> > >>> transmitted into the Tx FIFO. In such case, the packet is discarded
> > >>> with remaining length stored in vring->rem_padding. So paddings with
> > >>> zeros can be sent out when Tx space is available to maintain the
> > >>> integrity of the packet format. The padded packet will be dropped on
> > >>> the receiving side.
> > >>>
> > >>> Signed-off-by: Liming Sun <limings@nvidia.com>
> > >>
> > >> This doesn't really explain how it helps (other than avoiding the
> > >> message which sounds like just hiding the issue). That is, how this helps
> > >> to resume Tx? Or does Tx resume? There's nothing to indicate either way.
> > >
> > > As the commit message mentioned, the expired packet is discarded and the
> > > packet buffer is released (see changes of calling mlxbf_tmfifo_release_pkt()).
> > > The Tx will resume automatically once the FIFO space is available, such as
> > when
> > > external host driver starts to drain the TMFIFO. No need for any other logic.
> > 
> > Hmm, it seems to me that the same (resuming on FIFO space available)
> > will happen without this patch ?
> 
> Yes, it's true.
> 
> > 
> > So as Ilpo mentioned the only purpose here seems to be to avoid the warning
> > getting logged? And things work properly without this too ?
> > 
> > I guess the advantage of this patch is that during a blocked FIFO packets
> > get discarded rather the piling up ?
> > 
> > Regards,
> > 
> > Hans
> 
> Probably I misunderstood Ilpo's comments.
> Yes, the only purpose is to avoid the warning messages (since users and QA doesn't like these messages).
> It is only for networking packet, which seems reasonable to drop it if not able to complete the transmission in seconds.

Okay, makes much more sense now as I couldn't see anything that would have 
helped to resume from "stuck" or "failed" state.

I think the first paragraph of the commit message misleads the reader to 
think something is "stuck" or "failed". And since this doesn't exactly fix 
such an issue that is not there in the first place it leads to confusion.

Perhaps it would be good to try to rephrase the first paragraph such that 
it wouldn't hint something is stuck when there is only a delay spike in 
FIFO's consumer side (if I now understand the problem space correctly?).

-- 
 i.

> > >>> ---
> > >>>  drivers/platform/mellanox/mlxbf-tmfifo.c | 67
> > >> ++++++++++++++++++++++++
> > >>>  1 file changed, 67 insertions(+)
> > >>>
> > >>> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c
> > >> b/drivers/platform/mellanox/mlxbf-tmfifo.c
> > >>> index 5c683b4eaf10..f39b7b9d2bfe 100644
> > >>> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> > >>> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> > >>> @@ -47,6 +47,9 @@
> > >>>  /* Message with data needs at least two words (for header & data). */
> > >>>  #define MLXBF_TMFIFO_DATA_MIN_WORDS		2
> > >>>
> > >>> +/* Tx timeout in milliseconds. */
> > >>> +#define TMFIFO_TX_TIMEOUT			2000
> > >>> +
> > >>>  /* ACPI UID for BlueField-3. */
> > >>>  #define TMFIFO_BF3_UID				1
> > >>>
> > >>> @@ -62,12 +65,14 @@ struct mlxbf_tmfifo;
> > >>>   * @drop_desc: dummy desc for packet dropping
> > >>>   * @cur_len: processed length of the current descriptor
> > >>>   * @rem_len: remaining length of the pending packet
> > >>> + * @rem_padding: remaining bytes to send as paddings
> > >>>   * @pkt_len: total length of the pending packet
> > >>>   * @next_avail: next avail descriptor id
> > >>>   * @num: vring size (number of descriptors)
> > >>>   * @align: vring alignment size
> > >>>   * @index: vring index
> > >>>   * @vdev_id: vring virtio id (VIRTIO_ID_xxx)
> > >>> + * @tx_timeout: expire time of last tx packet
> > >>>   * @fifo: pointer to the tmfifo structure
> > >>>   */
> > >>>  struct mlxbf_tmfifo_vring {
> > >>> @@ -79,12 +84,14 @@ struct mlxbf_tmfifo_vring {
> > >>>  	struct vring_desc drop_desc;
> > >>>  	int cur_len;
> > >>>  	int rem_len;
> > >>> +	int rem_padding;
> > >>>  	u32 pkt_len;
> > >>>  	u16 next_avail;
> > >>>  	int num;
> > >>>  	int align;
> > >>>  	int index;
> > >>>  	int vdev_id;
> > >>> +	unsigned long tx_timeout;
> > >>>  	struct mlxbf_tmfifo *fifo;
> > >>>  };
> > >>>
> > >>> @@ -819,6 +826,50 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct
> > >> mlxbf_tmfifo_vring *vring,
> > >>>  	return true;
> > >>>  }
> > >>>
> > >>> +static void mlxbf_tmfifo_check_tx_timeout(struct mlxbf_tmfifo_vring
> > >> *vring)
> > >>> +{
> > >>> +	unsigned long flags;
> > >>> +
> > >>> +	/* Only handle Tx timeout for network vdev. */
> > >>> +	if (vring->vdev_id != VIRTIO_ID_NET)
> > >>> +		return;
> > >>> +
> > >>> +	/* Initialize the timeout or return if not expired. */
> > >>> +	if (!vring->tx_timeout) {
> > >>> +		/* Initialize the timeout. */
> > >>> +		vring->tx_timeout = jiffies +
> > >>> +			msecs_to_jiffies(TMFIFO_TX_TIMEOUT);
> > >>> +		return;
> > >>> +	} else if (time_before(jiffies, vring->tx_timeout)) {
> > >>> +		/* Return if not timeout yet. */
> > >>> +		return;
> > >>> +	}
> > >>> +
> > >>> +	/*
> > >>> +	 * Drop the packet after timeout. The outstanding packet is
> > >>> +	 * released and the remaining bytes will be sent with padding byte
> > >> 0x00
> > >>> +	 * as a recovery. On the peer(host) side, the padding bytes 0x00 will be
> > >>> +	 * either dropped directly, or appended into existing outstanding
> > >> packet
> > >>> +	 * thus dropped as corrupted network packet.
> > >>> +	 */
> > >>> +	vring->rem_padding = round_up(vring->rem_len, sizeof(u64));
> > >>> +	mlxbf_tmfifo_release_pkt(vring);
> > >>> +	vring->cur_len = 0;
> > >>> +	vring->rem_len = 0;
> > >>> +	vring->fifo->vring[0] = NULL;
> > >>> +
> > >>> +	/*
> > >>> +	 * Make sure the load/store are in order before
> > >>> +	 * returning back to virtio.
> > >>> +	 */
> > >>> +	virtio_mb(false);
> > >>> +
> > >>> +	/* Notify upper layer. */
> > >>> +	spin_lock_irqsave(&vring->fifo->spin_lock[0], flags);
> > >>> +	vring_interrupt(0, vring->vq);
> > >>> +	spin_unlock_irqrestore(&vring->fifo->spin_lock[0], flags);
> > >>> +}
> > >>> +
> > >>>  /* Rx & Tx processing of a queue. */
> > >>>  static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
> > >>>  {
> > >>> @@ -841,6 +892,7 @@ static void mlxbf_tmfifo_rxtx(struct
> > >> mlxbf_tmfifo_vring *vring, bool is_rx)
> > >>>  		return;
> > >>>
> > >>>  	do {
> > >>> +retry:
> > >>>  		/* Get available FIFO space. */
> > >>>  		if (avail == 0) {
> > >>>  			if (is_rx)
> > >>> @@ -851,6 +903,17 @@ static void mlxbf_tmfifo_rxtx(struct
> > >> mlxbf_tmfifo_vring *vring, bool is_rx)
> > >>>  				break;
> > >>>  		}
> > >>>
> > >>> +		/* Insert paddings for discarded Tx packet. */
> > >>> +		if (!is_rx) {
> > >>> +			vring->tx_timeout = 0;
> > >>> +			while (vring->rem_padding >= sizeof(u64)) {
> > >>> +				writeq(0, vring->fifo->tx.data);
> > >>> +				vring->rem_padding -= sizeof(u64);
> > >>> +				if (--avail == 0)
> > >>> +					goto retry;
> > >>> +			}
> > >>> +		}
> > >>> +
> > >>>  		/* Console output always comes from the Tx buffer. */
> > >>>  		if (!is_rx && devid == VIRTIO_ID_CONSOLE) {
> > >>>  			mlxbf_tmfifo_console_tx(fifo, avail);
> > >>> @@ -860,6 +923,10 @@ static void mlxbf_tmfifo_rxtx(struct
> > >> mlxbf_tmfifo_vring *vring, bool is_rx)
> > >>>  		/* Handle one descriptor. */
> > >>>  		more = mlxbf_tmfifo_rxtx_one_desc(vring, is_rx, &avail);
> > >>>  	} while (more);
> > >>> +
> > >>> +	/* Check Tx timeout. */
> > >>> +	if (avail <= 0 && !is_rx)
> > >>> +		mlxbf_tmfifo_check_tx_timeout(vring);
> > >>>  }
> > >>>
> > >>>  /* Handle Rx or Tx queues. */
> > >>>
> 
> 
--8323329-974403408-1704740595=:1762--

