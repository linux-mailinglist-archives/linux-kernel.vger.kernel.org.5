Return-Path: <linux-kernel+bounces-160164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8F8B3A12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8812428BCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3C2B2F2;
	Fri, 26 Apr 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2SJSFVp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E0175A5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141856; cv=none; b=Yfmm2VVrwZx/WRo2PEixwvlN3AaqGcotXzRON+mfuq5Vfp3rVjK5019/wBJ1YvVfxDva7NHsadOVW+El1TL+F5t8SDrzjnmCTGgqDlJhrMNB+C+CjEvVcy1ctn1E2q4Ser/srQDLuuE4t0fPjyynpmkhY22LzL1TJLFXTRJDneA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141856; c=relaxed/simple;
	bh=oPAF65Iv0IVA9xoI/dCjL7CezohA2J2fKenKSVL0DM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNCjeuIy3VI3mg12LqXeKuf5ckvQ6Y/1d1Vwf+WxALh1mmjp8C58QF//3GBah4EJpJGACHlB1mRb/DkokPpiX5rXdxNhF9+M8mjXZa3yKpYP5/s4av8CzXUPTFkOCSHFu4Q9AijLdB8lhSSLoc8vQfe2vG/gRg5Pt79nxCWy/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2SJSFVp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714141850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Po/iEila9vOgF/cEwaFixGoYPv3NXGuCxcYDjenzE0=;
	b=S2SJSFVpXl60D90Xiq9um/JhzkCZL+1kdapVWi7/4dhwjU9VO+Bz3c/4Z4FP+g7cCV5+d5
	NkbXfX35FJ15M7ByxmJ3uxqopZkTYGqQNmdn8XYCgClvK1rG0N2mIoKcKrEBCE0yOP3Tiq
	PoAkU42OlSE8fprF8L+fgwVk8OCxRGI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-Tp7iL8TsOVCes_nIrxZPwg-1; Fri,
 26 Apr 2024 10:30:45 -0400
X-MC-Unique: Tp7iL8TsOVCes_nIrxZPwg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0A033819C61;
	Fri, 26 Apr 2024 14:30:44 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.194.197])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 952C140F566;
	Fri, 26 Apr 2024 14:30:44 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 41EC3A80B9E; Fri, 26 Apr 2024 16:30:43 +0200 (CEST)
Date: Fri, 26 Apr 2024 16:30:43 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
Message-ID: <Ziu6k5cjXsaUpAYH@calimero.vinschen.de>
Mail-Followup-To: Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20240423134731.918157-1-vinschen@redhat.com>
 <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKv1J3AS3rEmEhFq5McHmM+L=32pWg3Wj4_drsdKUx77A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi Eric,

On Apr 23 16:10, Eric Dumazet wrote:
> On Tue, Apr 23, 2024 at 3:47 PM Corinna Vinschen <vinschen@redhat.com> wrote:
> >
> > From: Paolo Abeni <pabeni@redhat.com>
> >
> > Sabrina reports that the igb driver does not cope well with large
> > MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> > corruption on TX.
> >
> > An easy reproducer is to run ssh to connect to the machine.  With
> > MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.
> >
> > The root cause of the issue is that the driver does not take into
> > account properly the (possibly large) shared info size when selecting
> > the ring layout, and will try to fit two packets inside the same 4K
> > page even when the 1st fraglist will trump over the 2nd head.
> >
> > Address the issue forcing the driver to fit a single packet per page,
> > leaving there enough room to store the (currently) largest possible
> > skb_shared_info.
> >
> > Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAG")
> > Reported-by: Jan Tluka <jtluka@redhat.com>
> > Reported-by: Jirka Hladky <jhladky@redhat.com>
> > Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> > Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> > Tested-by: Corinna Vinschen <vinschen@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2: fix subject, add a simple reproducer
> >
> >  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > index a3f100769e39..22fb2c322bca 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -4833,6 +4833,7 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
> >
> >  #if (PAGE_SIZE < 8192)
> >         if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
> > +           SKB_HEAD_ALIGN(adapter->max_frame_size) > (PAGE_SIZE / 2) ||
> 
> I wonder if adding IGB_SKB_PAD would be needed ?
> 
> adapter->max_frame_size does not seem to include it.
> 
> I would try using all mtus between 1200 and 1280 to make sure this works.

Erm... did you mean between 1500 and 1580 by any chance?  1200 doesn't
really seem to make sense...

I tested this patch now with mtu 1500, 1540 and 1580 successfully.

Either way, I'm just heading into vacation, so I guess I'll pick this up
again when I'm back, unless Paolo takes another look during my absence.


Thanks,
Corinna


