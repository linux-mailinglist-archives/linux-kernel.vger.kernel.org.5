Return-Path: <linux-kernel+bounces-110045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC5188594C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4901F21B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD6583CC1;
	Thu, 21 Mar 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aWPwam1x"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969583CB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024986; cv=none; b=kAIslk2e4seZJ2CcVS4WTz+5eW68zfub1ZaHh5YghdUm6i+UxvpBK0cEWlW1Xhk8LqBUvR4DPsbhjpG18p7/WTvGrOaYjGElLyc4FhS5r9OLZJhXhMsiW7aGALoiTY1rDhRGFOVaTEFnHkmdnw4ynnBGO3Ir+rrWj2Mj3T2U8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024986; c=relaxed/simple;
	bh=EQ6hbRDXSCTTLbQhaUR33aI/6wiYbgEj/Sko9Wjmw00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faf5kqbysDDD5oMsmqj8HHNh21I9sXBqc8Z3R4cnu3GmDazwUJ4cXcRd8W8YKUqBKFFNtNM++bC8DajSi6lPMepoSqnrFW7jJchJU2LOIgp+1V9ttR/oZm1GvbHqVrBcgaNfAy5rJ4uLJyeuChUO6wr/yKS06ZzHpkA1rNVYY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aWPwam1x; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-414618e6820so7374105e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711024983; x=1711629783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6dKbdT6CKun5+cypb7qTPiuf+ERRmXIczUU4oFpp24=;
        b=aWPwam1xt6jJieVMQ5Zy9pafzF3M91jZcZNKFjM93JvC3qqN8j5g3JrjDBo3xeXVA2
         JwSFLoYo4NKWXCkltNcg3eJfTKGgDJI7WIHZXB8ZQxDgq7KvImSacJsrthniJZhj3srL
         cEx8xkA6aByNHeixrdTkjWYqOGEuvFDT3YyfbOXOzraBPGpbhS9Mj5lODYGC8/9jNqK3
         vU1K5Tv7t6IgYViH9hofDTISn5sa5Tc+b9lu+dQaOmstGl60keeMPt4QOl8PW4JEYdvD
         zAWtHAKVKRpS2BsFRs6ujatRPLtGwGpD2HF9E6IZjY802DeQPOALbiAz0caanFett0KX
         3Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711024983; x=1711629783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6dKbdT6CKun5+cypb7qTPiuf+ERRmXIczUU4oFpp24=;
        b=LncF4mx7VOZtfW9tmg/WeHOgeAf9v6gCNWdNT4AUyE5jzi8KHqjoiJtMlSmBE1MmrX
         vhx/xZlRzneA5KLyahftYx4SCWztPILnh7fp4lt2IOg7Ctf8kZPQcHDxgbVwSWkiC9hc
         HfvUql1m1WrkIPJJ6+DDUk5w3OIZsK/U2qZ3dy0NXPWZrg++lfWdy0nBguMfFZv+2EFD
         FvtsOh1QY6AmC815gY36HkuUILrQY7wUKjsZuFaJ547SzJ5LjIGHzVu7CDsQsgf0nTOe
         tnRQVJSjuP04aWzmeyeO+sjd8npMCZqe6ffuw/X/ghH5N3PHwZfjIRyoykVFt6f9gOoE
         6CFg==
X-Forwarded-Encrypted: i=1; AJvYcCVVtdeBcZagrE1liUu9oGoa79DSHyAiQ5dhl9c1NsuUlV56A/2T3VPb/UFXfOoDls6zIzWnAQLxKSXkd1/aaZXfzY7E30e/uuJHvOKU
X-Gm-Message-State: AOJu0YwFLm3x9GnEo1gwkfce8rRPnTXQ1BuxFhOBZm/srRue3DciYpDL
	xX+jn5f/yvPkujDbN8hwNG+wYqAqy9oU+ViaPWsNG4fWjn9SaJvyyivpgmco1ZI=
X-Google-Smtp-Source: AGHT+IHxyY6/Doi3TYpGzjLhayaFYmuqg56RBxJVjFfD8C4SZrFFDRbWca3ueZjy54Asj6OHPcofZg==
X-Received: by 2002:a05:600c:310f:b0:414:5ec3:8fcb with SMTP id g15-20020a05600c310f00b004145ec38fcbmr7811199wmo.23.1711024982740;
        Thu, 21 Mar 2024 05:43:02 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c468500b004132ae838absm5529132wmo.43.2024.03.21.05.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:43:02 -0700 (PDT)
Date: Thu, 21 Mar 2024 13:42:58 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Message-ID: <ZfwrUmU-HROSmULc@nanopsycho>
References: <20240320125635.1444-1-abelova@astralinux.ru>
 <Zfrmv4u0tVcYGS5n@nanopsycho>
 <b67f3efb-509e-4280-90f2-729d217c20c7@astralinux.ru>
 <ZfwSmlZ-Ie1dFlue@nanopsycho>
 <bec13e5c-0632-4841-adf9-38a47d290ffd@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bec13e5c-0632-4841-adf9-38a47d290ffd@astralinux.ru>

Thu, Mar 21, 2024 at 01:04:22PM CET, abelova@astralinux.ru wrote:
>
>
>21/03/24 13:57, Jiri Pirko пишет:
>> Thu, Mar 21, 2024 at 10:36:53AM CET, abelova@astralinux.ru wrote:
>> > 
>> > 20/03/24 16:38, Jiri Pirko пишет:
>> > > Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
>> > > > skb is an optional parameter, so it may be NULL.
>> > > > Add check defore dereference in eth_hdr.
>> > > > 
>> > > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
>> > > Either drop this line which provides no value, or attach a link to the
>> > > actual report.
>> > > 
>> > It is an established practice for our project. You can find 700+ applied
>> > patches with similar line:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=linuxtesting.org
>> Okay. So would it be possible to attach a link to the actual report?
>
>Unfortunately no as far as results of the SVACE static analysis tool are
>not available publicly at the moment.

So, don't mention it, has no value what so ever. No place for
advertisements like this.


>
>
>Also I agree that this is quite a minor fix, but I still insist
>that it would be better to add a check.

It is not possible (prove us wrong) to hit this bug in real world.
No point to fix nobug.


>
>> 
>> > 
>> > > > Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
>> > > This looks incorrect. I believe that this is the offending commit:
>> > > commit 690e36e726d00d2528bc569809048adf61550d80
>> > > Author: David S. Miller <davem@davemloft.net>
>> > > Date:   Sat Aug 23 12:13:41 2014 -0700
>> > > 
>> > >       net: Allow raw buffers to be passed into the flow dissector.
>> > > 
>> > Got it.
>> > 
>> > > > Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>> > > > ---
>> > > > net/core/flow_dissector.c | 2 +-
>> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
>> > > > 
>> > > > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>> > > > index 272f09251343..05db3a8aa771 100644
>> > > > --- a/net/core/flow_dissector.c
>> > > > +++ b/net/core/flow_dissector.c
>> > > > @@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
>> > > > 		rcu_read_unlock();
>> > > > 	}
>> > > > 
>> > > > -	if (dissector_uses_key(flow_dissector,
>> > > > +	if (skb && dissector_uses_key(flow_dissector,
>> > > > 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
>> > > > 		struct ethhdr *eth = eth_hdr(skb);
>> > > > 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
>> > > Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
>> > > FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?
>> > I agree, I'll send the second version.
>> > 
>> > Anastasia Belova
>> > 
>
>

