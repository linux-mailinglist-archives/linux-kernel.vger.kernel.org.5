Return-Path: <linux-kernel+bounces-118299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918F488B76E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD4FB22466
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBE18527A;
	Tue, 26 Mar 2024 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfzYT6Qy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CE5A7B4;
	Tue, 26 Mar 2024 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420148; cv=none; b=rs+y+3Pd4Die2MwPXBF4QxqARZyxxv9JIYJ2yXVIjD6tmbUkFWJD3q/OVzsCOnYjySShAf4u7QiTu5/ygGrd5FNm1DpWaq7Z6UruTTjBkpIE9E3jaei5foEEbOh9mukEaY+EdjqKjNh0JuRd3VY9LXuhEN04gTch6xZsH4831TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420148; c=relaxed/simple;
	bh=DzbYHLscCUSnCTsi0cUZu2GsJUAq1ezQAtFLnEB1Pis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a60v0QI4mSlI1T7lgj5xpJbmTNW2t2cKdQUS/Mx/VuTyZ+tE5K31GZDBKhVzC7xetrC9c8n+8plyOfN6EcFF6uvTRucBxs7Xfh3psCYuTi5DKPh4gjHMxalaWOmAEOTc8136PxSqcG9YVfLYdn8Mg3P5MtgoyvkokLYxol8IbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfzYT6Qy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711420146; x=1742956146;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DzbYHLscCUSnCTsi0cUZu2GsJUAq1ezQAtFLnEB1Pis=;
  b=KfzYT6QyRaisMRIc8px1e6Rn8KQodiqRHncCdBhy4KkeqMrDeZr1uM84
   alug+x2F217ErFdwlCt0Q1gXN4M697TpOeBfGkLtFTFc3Zve8EakxSVnF
   CQ2Md5A4IA9E6xvosT2F80xa1LT1KKWHGpHgHwRb02G0Urih1idkLqRro
   xSbuxjbPSl8JJVO9o+5+dIZnn4DYluo3feZTO3y16Hxy+txLTJyQ1z473
   VY3TFkMJCCCeKgXsH3gwp+zEdY27/nbPe9GXKNkvCzZMT0pEAfEa+hqZo
   vXRPa1BHpzsy54rgGVMoJi8qohegSG+bfXh2xFagdnfENYnAuVkRvI04E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17595653"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17595653"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20480787"
Received: from unknown (HELO vcostago-mobl3) ([10.124.221.210])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:29:05 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Kurt Kanzenbach
 <kurt@linutronix.de>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 xdp-hints@xdp-project.net
Subject: Re: [PATCH iwl-next,v4 1/1] igc: Add Tx hardware timestamp request
 for AF_XDP zero-copy packet
In-Reply-To: <20240325020928.1987947-1-yoong.siang.song@intel.com>
References: <20240325020928.1987947-1-yoong.siang.song@intel.com>
Date: Mon, 25 Mar 2024 19:29:04 -0700
Message-ID: <87h6gtpvyn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Song Yoong Siang <yoong.siang.song@intel.com> writes:

> This patch adds support to per-packet Tx hardware timestamp request to
> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
> user needs to enable Tx HW timestamp capability via igc_ioctl() with
> SIOCSHWTSTAMP cmd before sending xsk Tx hardware timestamp request.
>
> Same as implementation in RX timestamp XDP hints kfunc metadata, Timer 0
> (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 have
> four sets of timestamping registers. *skb and *xsk_tx_buffer pointers
> are used to indicate whether the timestamping register is already occupied.
>
> Furthermore, a boolean variable named xsk_pending_ts is used to hold the
> transmit completion until the tx hardware timestamp is ready. This is
> because, for i225/i226, the timestamp notification event comes some time
> after the transmit completion event. The driver will retrigger hardware irq
> to clean the packet after retrieve the tx hardware timestamp.
>
> Besides, xsk_meta is added into struct igc_tx_timestamp_request as a hook
> to the metadata location of the transmit packet. When the Tx timestamp
> interrupt is fired, the interrupt handler will copy the value of Tx hwts
> into metadata location via xsk_tx_metadata_complete().
>
> This patch is tested with tools/testing/selftests/bpf/xdp_hw_metadata
> on Intel ADL-S platform. Below are the test steps and results.
>
> Test Step 1: Run xdp_hw_metadata app
>  ./xdp_hw_metadata <iface> > /dev/shm/result.log
>
> Test Step 2: Enable Tx hardware timestamp
>  hwstamp_ctl -i <iface> -t 1 -r 1
>
> Test Step 3: Run ptp4l and phc2sys for time synchronization
>
> Test Step 4: Generate UDP packets with 1ms interval for 10s
>  trafgen --dev <iface> '{eth(da=<addr>), udp(dp=9091)}' -t 1ms -n 10000
>
> Test Step 5: Rerun Step 1-3 with 10s iperf3 as background traffic
>
> Test Step 6: Rerun Step 1-4 with 10s iperf3 as background traffic
>
> Based on iperf3 results below, the impact of holding tx completion to
> throughput is not observable.
>
> Result of last UDP packet (no. 10000) in Step 4:
> poll: 1 (0) skip=99 fail=0 redir=10000
> xsk_ring_cons__peek: 1
> 0x5640a37972d0: rx_desc[9999]->addr=f2110 addr=f2110 comp_addr=f2110 EoP
> rx_hash: 0x2049BE1D with RSS type:0x1
> HW RX-time:   1679819246792971268 (sec:1679819246.7930) delta to User RX-time sec:0.0000 (14.990 usec)
> XDP RX-time:   1679819246792981987 (sec:1679819246.7930) delta to User RX-time sec:0.0000 (4.271 usec)
> No rx_vlan_tci or rx_vlan_proto, err=-95
> 0x5640a37972d0: ping-pong with csum=ab19 (want 315b) csum_start=34 csum_offset=6
> 0x5640a37972d0: complete tx idx=9999 addr=f010
> HW TX-complete-time:   1679819246793036971 (sec:1679819246.7930) delta to User TX-complete-time sec:0.0001 (77.656 usec)
> XDP RX-time:   1679819246792981987 (sec:1679819246.7930) delta to User TX-complete-time sec:0.0001 (132.640 usec)
> HW RX-time:   1679819246792971268 (sec:1679819246.7930) delta to HW TX-complete-time sec:0.0001 (65.703 usec)
> 0x5640a37972d0: complete rx idx=10127 addr=f2110
>
> Result of iperf3 without tx hwts request in step 5:
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  2.74 GBytes  2.36 Gbits/sec    0             sender
> [  5]   0.00-10.05  sec  2.74 GBytes  2.34 Gbits/sec                  receiver
>
> Result of iperf3 running parallel with trafgen command in step 6:
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  2.74 GBytes  2.36 Gbits/sec    0             sender
> [  5]   0.00-10.04  sec  2.74 GBytes  2.34 Gbits/sec                  receiver
>
> Co-developed-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---
> V1: https://patchwork.kernel.org/project/netdevbpf/patch/20231215162158.951925-1-yoong.siang.song@intel.com/
> V2: https://patchwork.kernel.org/project/netdevbpf/cover/20240301162348.898619-1-yoong.siang.song@intel.com/
> V3: https://patchwork.kernel.org/project/netdevbpf/cover/20240303083225.1184165-1-yoong.siang.song@intel.com/
>
> changelog:
> V1 -> V2
> - In struct igc_tx_timestamp_request, keep a pointer to igc_tx_buffer,
>   instead of pointing xsk_pending_ts (Vinicius).
> - In struct igc_tx_timestamp_request, introduce buffer_type to indicate
>   whether skb or igc_tx_buffer pointer should be use (Vinicius).
> - In struct igc_metadata_request, remove igc_adapter pointer (Vinicius).
> - When request tx hwts, copy the value of cmd_type, instead of using
>   pointer (Vinicius).
> - For boolean variable, use true and false, instead of 1 and 0 (Vinicius).
> - In igc_xsk_request_timestamp(), make an early return if none of the 4 ts
>   registers is available (Vinicius).
> - Create helper functions to clear tx buffer and skb for tstamp (John).
> - Perform throughput test with mix traffic (Vinicius & John).
> V2 -> V3
> - Improve tstamp reg searching loop for better readability (John).
> - In igc_ptp_free_tx_buffer(), add comment to inform user that
>   tstamp->xsk_tx_buffer and tstamp->skb are in union (John).
> V3 -> V4
> - Add protection with xp_tx_metadata_enabled (Kurt & Maciej).
> ---
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  71 ++++++++------
>  drivers/net/ethernet/intel/igc/igc_main.c | 113 ++++++++++++++++++++--
>  drivers/net/ethernet/intel/igc/igc_ptp.c  |  51 ++++++++--
>  3 files changed, 195 insertions(+), 40 deletions(-)
>

[...]

> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index 885faaa7b9de..1bb026232efc 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -11,6 +11,7 @@
>  #include <linux/ktime.h>
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
> +#include <net/xdp_sock_drv.h>
>  
>  #define INCVALUE_MASK		0x7fffffff
>  #define ISGN			0x80000000
> @@ -545,6 +546,30 @@ static void igc_ptp_enable_rx_timestamp(struct igc_adapter *adapter)
>  	wr32(IGC_TSYNCRXCTL, val);
>  }
>  
> +static void igc_ptp_free_tx_buffer(struct igc_adapter *adapter,
> +				   struct igc_tx_timestamp_request *tstamp)
> +{
> +	if (tstamp->buffer_type == IGC_TX_BUFFER_TYPE_XSK) {
> +		/* Release the transmit completion */
> +		tstamp->xsk_tx_buffer->xsk_pending_ts = false;
> +
> +		/* Note: tstamp->skb and tstamp->xsk_tx_buffer are in union.
> +		 * By setting tstamp->xsk_tx_buffer to NULL, tstamp->skb will
> +		 * become NULL as well.
> +		 */
> +		tstamp->xsk_tx_buffer = NULL;
> +		tstamp->buffer_type = 0;
> +
> +		/* Trigger txrx interrupt for transmit completion */
> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
> +
> +		return;
> +	}
> +
> +	dev_kfree_skb_any(tstamp->skb);
> +	tstamp->skb = NULL;
> +}
> +
>  static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
>  {
>  	unsigned long flags;
> @@ -555,8 +580,8 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
>  	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>  		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
>  
> -		dev_kfree_skb_any(tstamp->skb);
> -		tstamp->skb = NULL;
> +		if (tstamp->skb)
> +			igc_ptp_free_tx_buffer(adapter, tstamp);
>  	}
>  

More a question: you are potentially triggering an interrupt from
igc_ptp_clear_tx_tstamp() (igc_xsk_wakeup()) which can be called from
igc_down(). So, how does it work when there's a pending timestamp and
you remove the igc module? (example of a situation that it might be
problematic).


Cheers,
-- 
Vinicius

