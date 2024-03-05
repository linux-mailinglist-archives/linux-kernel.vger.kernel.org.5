Return-Path: <linux-kernel+bounces-91796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7658716C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406711F22001
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B27E774;
	Tue,  5 Mar 2024 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMG+DDAL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8724C637;
	Tue,  5 Mar 2024 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623724; cv=none; b=px9uVeSPDHWnGslzQm0Z60CVuJVJAWus07E7ZUw4jKBrY5lBU+VkWTyvEzZeBC6YDtV+9G8wEjmwXpZ4k40nT6Fg/bRDpQxRuTU+B8b51RGoh72VCv1BTk1fbwVfdLlPRybkqlYbwoFfazG2t92FyL861AeeEyDtqIzpriluGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623724; c=relaxed/simple;
	bh=0CSkO4V5DXVEFBREqHoKNNDYXRtYsWIaR34aGSPoS2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NumHkZvafMGAJe5u0FdmfMreBzLC34wKBgIoe9z1j969leRbwX6YtpWSY+IuWf2wQKlPwWluVhKygoTUW3q8+RuTiZpytj9J/Fug06vuj+6rlwalXdyFMV+ztizQg6sNNSDcoBv4UQ9+qGkyW1ny13emQ5vzuVcizoutY2CulIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMG+DDAL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709623723; x=1741159723;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0CSkO4V5DXVEFBREqHoKNNDYXRtYsWIaR34aGSPoS2E=;
  b=MMG+DDAL4fU9Tt78ThCfvcslTxakcTS97uFkQ/pN9HR7oueeLdAB+2ig
   8ROLH6aoF3qKF7CICnUhwGTlw5b11TUkF/EIMo2KGdxTSBHvhyklKaCr+
   u2ORCHyJfPVlyB7waLYj7l32PBp0g321T04HEMEF8OisT1ui52wUZt1dt
   RrqfbeehIBk7v1XhuLwZ4cDbSCsiNGQS+BMC4qo+BjPHgH6fofmWu+8MR
   ajgpr48yx5ySJbNyvbS9tQePe3H92XaFdmxjdlAhToJXHyAY+J8aNu2/K
   eXixJ+/fzYQR/WZYZl62Ly7VYp3pRZq67BA0hXs0U6ShRsR3Yoy3tgXob
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15585538"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="15585538"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:28:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9354222"
Received: from agoll-mobl.ger.corp.intel.com (HELO [10.245.176.64]) ([10.245.176.64])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:28:37 -0800
Message-ID: <76621a84-d5c5-40c2-ac51-db0ec57be472@linux.intel.com>
Date: Tue, 5 Mar 2024 09:28:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net 1/1] igc: avoid returning frame
 twice in XDP_REDIRECT
To: Florian Kauer <florian.kauer@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jithu Joseph <jithu.joseph@intel.com>, Andre Guedes
 <andre.guedes@intel.com>, Vedang Patel <vedang.patel@intel.com>
Cc: netdev@vger.kernel.org, kurt@linutronix.de, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
References: <20240219090843.9307-1-florian.kauer@linutronix.de>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20240219090843.9307-1-florian.kauer@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/2024 11:08, Florian Kauer wrote:
> When a frame can not be transmitted in XDP_REDIRECT
> (e.g. due to a full queue), it is necessary to free
> it by calling xdp_return_frame_rx_napi.
> 
> However, this is the reponsibility of the caller of
> the ndo_xdp_xmit (see for example bq_xmit_all in
> kernel/bpf/devmap.c) and thus calling it inside
> igc_xdp_xmit (which is the ndo_xdp_xmit of the igc
> driver) as well will lead to memory corruption.
> 
> In fact, bq_xmit_all expects that it can return all
> frames after the last successfully transmitted one.
> Therefore, break for the first not transmitted frame,
> but do not call xdp_return_frame_rx_napi in igc_xdp_xmit.
> This is equally implemented in other Intel drivers
> such as the igb.
> 
> There are two alternatives to this that were rejected:
> 1. Return num_frames as all the frames would have been
>     transmitted and release them inside igc_xdp_xmit.
>     While it might work technically, it is not what
>     the return value is meant to repesent (i.e. the
>     number of SUCCESSFULLY transmitted packets).
> 2. Rework kernel/bpf/devmap.c and all drivers to
>     support non-consecutively dropped packets.
>     Besides being complex, it likely has a negative
>     performance impact without a significant gain
>     since it is anyway unlikely that the next frame
>     can be transmitted if the previous one was dropped.
> 
> The memory corruption can be reproduced with
> the following script which leads to a kernel panic
> after a few seconds.  It basically generates more
> traffic than a i225 NIC can transmit and pushes it
> via XDP_REDIRECT from a virtual interface to the
> physical interface where frames get dropped.
> 
>     #!/bin/bash
>     INTERFACE=enp4s0
>     INTERFACE_IDX=`cat /sys/class/net/$INTERFACE/ifindex`
> 
>     sudo ip link add dev veth1 type veth peer name veth2
>     sudo ip link set up $INTERFACE
>     sudo ip link set up veth1
>     sudo ip link set up veth2
> 
>     cat << EOF > redirect.bpf.c
> 
>     SEC("prog")
>     int redirect(struct xdp_md *ctx)
>     {
>         return bpf_redirect($INTERFACE_IDX, 0);
>     }
> 
>     char _license[] SEC("license") = "GPL";
>     EOF
>     clang -O2 -g -Wall -target bpf -c redirect.bpf.c -o redirect.bpf.o
>     sudo ip link set veth2 xdp obj redirect.bpf.o
> 
>     cat << EOF > pass.bpf.c
> 
>     SEC("prog")
>     int pass(struct xdp_md *ctx)
>     {
>         return XDP_PASS;
>     }
> 
>     char _license[] SEC("license") = "GPL";
>     EOF
>     clang -O2 -g -Wall -target bpf -c pass.bpf.c -o pass.bpf.o
>     sudo ip link set $INTERFACE xdp obj pass.bpf.o
> 
>     cat << EOF > trafgen.cfg
> 
>     {
>       /* Ethernet Header */
>       0xe8, 0x6a, 0x64, 0x41, 0xbf, 0x46,
>       0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
>       const16(ETH_P_IP),
> 
>       /* IPv4 Header */
>       0b01000101, 0,   # IPv4 version, IHL, TOS
>       const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
>       const16(2),      # IPv4 ident
>       0b01000000, 0,   # IPv4 flags, fragmentation off
>       64,              # IPv4 TTL
>       17,              # Protocol UDP
>       csumip(14, 33),  # IPv4 checksum
> 
>       /* UDP Header */
>       10,  0, 1, 1,    # IP Src - adapt as needed
>       10,  0, 1, 2,    # IP Dest - adapt as needed
>       const16(6666),   # UDP Src Port
>       const16(6666),   # UDP Dest Port
>       const16(1008),   # UDP length (UDP header 8 bytes + payload length)
>       csumudp(14, 34), # UDP checksum
> 
>       /* Payload */
>       fill('W', 1000),
>     }
>     EOF
> 
>     sudo trafgen -i trafgen.cfg -b3000MB -o veth1 --cpp
> 
> Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>

