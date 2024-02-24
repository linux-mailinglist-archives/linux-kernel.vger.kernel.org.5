Return-Path: <linux-kernel+bounces-79517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A889986238A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0131C21337
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552B17C6E;
	Sat, 24 Feb 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XvrGDp03"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C186FDC;
	Sat, 24 Feb 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765164; cv=none; b=FnsPiopWcx1FTjrOPogL2Lbg1YE/vNQtDi5o+FZ3f8Gmsx6B9Z+U68zXT4uNuI9fVeXA3awgxT/zBip9Pznf1kQ5JiOVartdM3R5kToben01b+FHfxd7DdU3T2fWcCZ0DRSBUf+WszXzDOcOLGs2KiHaxgfu3oR1DxAvjIh1Als=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765164; c=relaxed/simple;
	bh=jRwcTTeNNZoy82MiJGTI/8OataEYJx2/rcMXqLB54uw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2ap0Uskn7ZGF763E/f4OJKGLc3dM0TIHJ3yP78JpLvy4loV/JqDEsaYyvxI1QhBpoFlMDtzuxG+IZ88FUUDF9+sTh3Obmp0Bv6WeMQSqxljwnzXJxF25L7IsYFIE+PkSruGr4DfwRhCo2xWV+bCrrTQ0P4lDr9h5Xw51O59Jfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XvrGDp03; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41O8x6sm030540;
	Sat, 24 Feb 2024 02:59:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708765146;
	bh=s3DvfR+dgFcUMcE14p+BGppF2mRtLuO4aTC7Xqj/Pj8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=XvrGDp03JC5fT/Z7aeOCYO+yn1XJiEx0EAodVBS13hDd7c+SzhXbCYPJjK8x3R7dX
	 03BgFyimpTdiXa5jVjn/zbX9oV6O8tE1FrGetQlOPIoWRhg7RMrq3cKJK/6Pjr6G6k
	 OHo7X3JrGgdICNrFrng4A6kcEBHKfJ4xIbgMcaQc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41O8x6uH011030
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Feb 2024 02:59:06 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Feb 2024 02:59:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Feb 2024 02:59:06 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41O8x5SZ049711;
	Sat, 24 Feb 2024 02:59:06 -0600
Date: Sat, 24 Feb 2024 14:29:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Chintan Vankar <c-vankar@ti.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next 2/2] net: ethernet: ti: am65-cpsw: Enable RX HW
 timestamp only for PTP packets
Message-ID: <03d53049-e649-4714-8ad4-49619a5e9475@ti.com>
References: <20240215110953.3225099-1-c-vankar@ti.com>
 <20240215110953.3225099-2-c-vankar@ti.com>
 <4c82705d-b05c-4ee8-88ed-42f944a023ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c82705d-b05c-4ee8-88ed-42f944a023ac@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Feb 19, 2024 at 12:59:55PM +0200, Roger Quadros wrote:
> Hi,
> 
> On 15/02/2024 13:09, Chintan Vankar wrote:
> > The CPSW peripherals on J7AHP, J7VCL, J7AEP, J7ES, AM64 SoCs have
> > an errata i2401 "CPSW: Host Timestamps Cause CPSW Port to Lock up".
> 
..

> >  
> > @@ -856,6 +852,9 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
> >  		ndev_priv = netdev_priv(ndev);
> >  		am65_cpsw_nuss_set_offload_fwd_mark(skb, ndev_priv->offload_fwd_mark);
> >  		skb_put(skb, pkt_len);
> > +		skb_reset_mac_header(skb);
> 
> Why do you need to add skb_reset_mac_header here?
> 
> > +		if (port->rx_ts_enabled)
> > +			am65_cpts_rx_timestamp(common->cpts, skb);
> 
> The timestamp should be added before you do skb_put().

Roger,

Could you please clarify why the timestamp should be added before
skb_put()?

Regards,
Siddharth.

