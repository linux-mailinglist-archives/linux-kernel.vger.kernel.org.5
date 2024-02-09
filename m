Return-Path: <linux-kernel+bounces-60163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E20DF8500EE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB657B25DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663E53984A;
	Fri,  9 Feb 2024 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="atKZ0AuX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D9383BF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707523114; cv=none; b=JQY8jRp/CDOovwIteJgEXW+A9PzLiHrUM3sP5vtquGbc86F63LkGb5SfU5LSbMVFU9x+6VaKkCLWDCpOsCEqUV3+02kbB+0nuZN7WI6Fs9oFiSdyLWxodQvfNRr9U44aIfhBF6KhLLBo4H3sTxXRkUwihV8N2qI4l7ZfwHFHi2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707523114; c=relaxed/simple;
	bh=zBngdWwOtkwqsg/A1+AFDXi53ueW3fBgEzocJEDm9as=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m45ZhpyU70CW1uWffNNSMlVEd7ZifEzkypN6J/y8rRnFS9q2VKAJNL/mcxg7P3M7NbhDeMyHwxUhVQBaI71Ly5U65ocBtujrOX5WCx57AWYxeP8H0BMoGBrnWCUgWJn+xOVnCrrWyBKCLeL1QCnyVn1EJ8mHJFSL00jAR40ovBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=atKZ0AuX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d918008b99so12066315ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 15:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707523112; x=1708127912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSmZPoI4Ym7um/SX0qHI5LCwnrN5IVC3f+cT7JH8MHQ=;
        b=atKZ0AuX/TkRe41iwITrnh2kP98ufoRkD2yqBTt0a8vpQFTdbMBwu3Nnc/ae20IDIZ
         OaFYv81W/VfumOfJhHfYgL6O0xDpLPVhnHcdODYVqokmvdxHlFNeM33XHSOaQ79we4ea
         k/VcG6qnDB0kxohfMDUv9FLKSycxn1zqkngv0MstqirHnKcprsyFNc6XYJBzBRmBlHF2
         n6DBajpn+dKeVCKbrOnbHUDQ8jhzDCBpA4DHyEt22WM/qtOxSWRvZxNaGtQIGqf7cS6q
         Bl8Jfyq2iJ4D79khjx7YXkyOz/LhwiJh9d0LIaBczI71OFwo58ymKj8fgqkXjDH/knzX
         6e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707523112; x=1708127912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSmZPoI4Ym7um/SX0qHI5LCwnrN5IVC3f+cT7JH8MHQ=;
        b=l4v9u3W02QePbH2MlVt/ycA1aWBJ4XHgvVOLKkF8YO3KW/65kn79OqPgsPWNwjwUOv
         upc44Yl/xIJ6ANe2pg5fAJ8Fj+YNbr7qO9KiE+bv3MSBAsB68/0COsq96yp9tulgSJXo
         TYDJ38FmlyoIsQXfyZek0+sHS6nJvYbrIxUIXhlq1ZLdGona3njg3tpgXstQBl9ICkS6
         1GmFYH0jKDDtsFrDO8BXfxLIXqqhvMsbBzCr/cuKnh+AKczuSQLAjqyRlkruKsRU6lh3
         lNo6B0M/cBRpsa4V+0vc/cA0pK1nQ63lHDcHCYyLTa+1v8NzUV6IHSAVr0pZlWGpgc7R
         10Cg==
X-Gm-Message-State: AOJu0Yz8hC3xwCOMfzICQWiohLXWDYWxxsYyy9dWFFeVtnIc7Pg+TL9I
	qBiVYcXQZyhO4qoROsFuMjYnTQcVj3cmMutKpyxHbLpYjBSUjoOjZBf8jsffTIU=
X-Google-Smtp-Source: AGHT+IEgGBL93rnBne+EbdfTxqB4wkau7VEWbJd7XSLV2Rlj7VMkpC3JeoDqU82g6+oddTBCB7FqCg==
X-Received: by 2002:a17:902:6b46:b0:1d9:6091:6f3b with SMTP id g6-20020a1709026b4600b001d960916f3bmr859189plt.47.1707523112376;
        Fri, 09 Feb 2024 15:58:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsdxzReEisYj6VmLU28oqDlJl9RrjAoTrzfJXV99wp4hKDCvjr6V1IObGqTzBlJKH2ilf5zd0Tj/9WnDXYUP3b8+6kemx6EPrW0OV8diz+PWuK9WwQtn2hO9cLfUpQdrwTUK50SqPlBf6XDcEnmuBy4bG34ROEOL8kig46q4pGwnAJlsTKa6u68fvpXR1RS7k2KFkNKu5gQDLCMxD3y33yUDhzotj6uQnHCiE4ArpKPHN4gV6BOcTQMbtxGK2vpj/PO4EBIXbxj3oT7jDBiRn90bIgI0JDV4OlAooEf4WOJfpU85uUh4WhuLHgKfAV1CyQNdfK5WIiEHEWNa7wnVAzRTEURpLmZVqg3KJcfZDIYLeEVop3OhRJw4tCprxa1zBKbpuHZ+QRILn0vpPNMInmw8qGYtsgB5WhIc7u63s4s7k9btbalJ6G3cZilMjCQrnbM2cnbkC9HxLuDzPsUKI9wlKBGmWxl3PcC+w3aLJcYjjV8sFsGK6T+RPxcDjZyT6yAKPiqbyxVK6GYSutWHWdCpQ/jxgkndfGJWW0qhekKqDCIAXSfuJtPDm0+KAKsITLFOnJ4mNMB26XJGI38QThb68zNK8V0oC0wwY=
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001d989dd19b0sm2022197plz.140.2024.02.09.15.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:58:32 -0800 (PST)
Date: Fri, 9 Feb 2024 15:58:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
 (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2] net/sched: actions report errors with
 extack
Message-ID: <20240209155830.448c2215@hermes.local>
In-Reply-To: <20240209134112.4795eb19@kernel.org>
References: <20240205185537.216873-1-stephen@networkplumber.org>
	<20240208182731.682985dd@kernel.org>
	<20240209131119.6399c91b@hermes.local>
	<20240209134112.4795eb19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Feb 2024 13:41:12 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 9 Feb 2024 13:11:19 -0800 Stephen Hemminger wrote:
> > On Thu, 8 Feb 2024 18:27:31 -0800
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> > > > -	if (!tb[TCA_ACT_BPF_PARMS])
> > > > +	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_ACT_BPF_PARMS)) {
> > > > +		NL_SET_ERR_MSG(extack, "Missing required attribute");      
> > > 
> > > Please fix the userspace to support missing attr parsing instead.    
> > 
> > I was just addressing the error handling. This keeps the same impact as
> > before, i.e no userspace API change.  
> 
> I mean that NL_REQ_ATTR_CHECK() should be more than enough by itself.
> We have full TC specs in YAML now, we can hack up a script to generate
> reverse parsing tables for iproute2 even if you don't want to go full
> YNL.

Ok, then will take the err msg across all places using NL_REQ_ATTR_CHECK?

Would prefer not to add the complexity of reverse parsing tables, that gets ugly fast.

