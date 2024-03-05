Return-Path: <linux-kernel+bounces-91648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64D8714A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7E51F22AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527A405DC;
	Tue,  5 Mar 2024 04:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FElsCGGa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CC6FB5;
	Tue,  5 Mar 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612466; cv=none; b=pbTlOgCU/hV+GvkBjDnAY8ssQdRQIeNpzBr7zHT1TCU0fFfLm3sh1MQ+bOE5Z1mbrpuoM5Hui9iOQHZLdjNB4gj7ZHISfnnDJkNBHcgWAmI0lFARFnsOuojjOn9ZfnLiObolb8Bz7DWhAOTr4/Vnd8qstfKYuzM6sd3EgtG1cPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612466; c=relaxed/simple;
	bh=1WHkQK/Ja5W+APKzZ4IYM8Vsp3euVtIzyGWw7tf7y6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqQROgEGxcRVgaiNv4F7+9Sb+szqrp2/qJtgloNWaNcNgSuITLlWWBKnyhZXQBKBmPJfqhGNXwHQZ8NboNOFgK0UttgNTWwR7ZqHjBTQt/HSFzGtZi87oHisXs4IXY8pVeTI/wTB7JSLIZt39jV5k+MfpM54eXjiIeCTp5uZ9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FElsCGGa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709612463; x=1741148463;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1WHkQK/Ja5W+APKzZ4IYM8Vsp3euVtIzyGWw7tf7y6A=;
  b=FElsCGGa4+8opnGv+3B2XTWr1ARr9LwLFhe8t6sp1K2RQelQNjrnkI+C
   nwpbbNYgFFNXSQWwTfH9eSyH1vOvKSjiUEmat4swCBeDcSSs8SvxcRezw
   XNR4DRbptPV97nfN2l/EJzC2Cyfs9ZCMGE+xWTU4AzfpwznE/9iLCqxfl
   ktT6dKGaKgj61JZYz2do65CqZ2Xk2wDXk1HWaPZN4bhBVxKzekjjqwOxt
   tpgmkNyQM7A/GPUzGwB7pErEEk6RdKHYUeTpB3wHKK7T7li+u11Bt8Hz8
   rwxixG/v6bzOk5WHYezhaFUPmH19qNU56yoT4wy+3m5dCySXO5GmoH8K0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4300750"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4300750"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 20:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40216302"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.102.58]) ([10.247.102.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 20:20:55 -0800
Message-ID: <6fbbd36a-20f5-43db-97fc-c8755a82a159@linux.intel.com>
Date: Tue, 5 Mar 2024 12:20:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/9] net: phylink: provide
 mac_get_pcs_neg_mode() function
To: "Voon, Weifeng" <weifeng.voon@intel.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Andrew Halaney
 <ahalaney@redhat.com>, Serge Semin <fancer.lancer@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "Sit, Michael Wei Hong" <michael.wei.hong.sit@intel.com>,
 "Lai, Peter Jun Ann" <peter.jun.ann.lai@intel.com>,
 "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
References: <20240215030500.3067426-1-yong.liang.choong@linux.intel.com>
 <20240215030500.3067426-2-yong.liang.choong@linux.intel.com>
 <Zc47T/qv8Xg2SA21@shell.armlinux.org.uk>
 <PH7PR11MB65210C62342088CF5C484A2888552@PH7PR11MB6521.namprd11.prod.outlook.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <PH7PR11MB65210C62342088CF5C484A2888552@PH7PR11MB6521.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/2/2024 2:58 pm, Voon, Weifeng wrote:
>>> For instance, if the interface switches from 2500baseX to SGMII mode,
>>> and the current link mode is MLO_AN_PHY, calling
>> 'phylink_pcs_neg_mode'
>>> would yield PHYLINK_PCS_NEG_OUTBAND. Since the MAC and PCS driver
>>> require PHYLINK_PCS_NEG_INBAND_ENABLED, the
>> 'mac_get_pcs_neg_mode'
>>> function will calculate the mode based on the interface, current link
>>> negotiation mode, and advertising link mode, returning
>>> PHYLINK_PCS_NEG_OUTBAND to enable the PCS to configure the correct
>> settings.
>>
>> This paragraph doesn't make sense - at least to me. It first talks about
>> requiring PHYLINK_PCS_NEG_INBAND_ENABLED when in SGMII mode. On
>> this:
> 
> The example given here is a very specific condition and that probably why there are some confusions here. Basically, this patch provides an optional function for MAC driver to change the phy interface on-the-fly without the need of reinitialize the Ethernet driver. As we know that the 2500base-x is messy, in our case the 2500base-x does not support inband. To complete the picture, we are using SGMII c37 to handle speed 10/100/1000. Hence, to enable user to switch link speed from 2500 to 1000/100/10 and vice versa on-the-fly, the phy interface need to be configured to inband SGMII for speed 10/100/1000, and outband 2500base-x for speed 2500. Lastly, the newly introduced "mac_get_pcs_neg_mode"callback function enables MAC driver to reconfigure pcs negotiation mode to inband or outband based on the interface mode, current link negotiation mode, and advertising link mode.
> 
>>
>> 1) are you sure that the hardware can't be programmed for the SGMII
>> symbol repititions?
>>
> 
> No, the HW can be program for SGMII symbol repetitions.
> 
>> 2) what happens if you're paired with a PHY (e.g. on a SFP module) which
>> uses SGMII but has no capability of providing the inband data?
>> (They do exist.) If your hardware truly does require inband data, it is going to
>> be fundamentally inoperative with these modules.
>>
> 
> Above explanation should have already cleared your doubts. Inband or outband capability is configured based on the phy interface.
> 
>> Next, you then talk about returning PHYLINK_PCS_NEG_OUTBAND for the
>> "correct settings". How does this relate to the first part where you basically
>> describe the problem as SGMII requring inband? Basically the two don't
>> follow.
> 
> It should be a typo mistake. SGMII should return PHYLINK_PCS_NEG_INBAND_ENABLED.
> 
>>
>> How, from a design point of view, because this fundamentally allows drivers
>> to change how the system behaves, it will allow radically different behaviours
>> for the same parameters between different drivers.
>> I am opposed to that - I want to see a situation where we have uniform
>> behaviour for the same configuration, and where hardware doesn't support
>> something, we have some way to indicate that via some form of capabilities.
>>
> 
> Hi Russell,
> If I understand you correctly, MAC driver should not interfere with pcs negotiation mode and it should be standardized in the generic function, e.g., phylink_pcs_neg_mode()?
> 
>> The issue of whether 2500base-X has inband or not is a long standing issue,
>> and there are arguments (and hardware) that take totally opposing views on
>> this. There is hardware where 2500base-X inband _must_ be used or the link
>> doesn't come up. There is also hardware where 2500base-X inband is not
>> "supported" in documentation but works in practice. There is also hardware
>> where 2500base-X inband doesn't work. The whole thing is a total mess
>> (thanks IEEE 802.3 for not getting on top of this early enough... and what's
>> now stated in 802.3 for 2500base-X is now irrelevant because they were too
>> late to the
>> party.)
>>
> 
> Agreed. And I have also seen some of your comments regarding the 2500SGMII and 2500BASEX.
> 
Hi Russell,

Did the previous reply clear your doubt?

If we understand you correctly that MAC driver should not interfere with 
pcs negotiation mode and it should be standardized in the generic function.
If implement what you suggested earlier that during interface mode change 
then update the `cur_link_an_mode` but not cfg_link_an_mode: 
https://patchwork.kernel.org/project/netdevbpf/patch/20230921121946.3025771-4-yong.liang.choong@linux.intel.com/?

Would that be a better solution?
So that 'phylink_pcs_neg_mode' function still can serve as the generic for 
all the drivers.

Do you have anything in mind that we can handle better for this patch series?
or the solution can be aligned with what you are going to implement in the 
future?

