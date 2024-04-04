Return-Path: <linux-kernel+bounces-131913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5DF898D84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195C41C2619A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877C12EBDC;
	Thu,  4 Apr 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajIKeu4s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6906110962
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253129; cv=none; b=upIh4TMT2TqEnQkdrPk4Ca6eWEEb1ImIKXEQ5F/2rmZH97zriN1/H2MhOWy45KemZMYf1J5z8fsr7+5t2eWV5j7MHXJm/GUCAuzZHV/oFR9cDJrNnfgG81zSd6njo4UVgSguuMvEWRWIM9yZOTRYA71cWgQGWAKd6KWflA5eRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253129; c=relaxed/simple;
	bh=MdM0y2PRyWI7KHw2LzBtU/nJ21hpHcvfN4gely6M3Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFAUUX1jCDhFrQH0HhDfGVgv26Cd0nVeceNkwE8pD0ISQNxa+AHrgTeeCCUs/f500DY2+/1zh7CsW32NQ4V86WXLHrhRxzBjfOoatkEVztkf/yO07XX7I2bsK6lbrEdRdw+iVOA85WDSbIQCk+8fsvDVbnHftjNdr8mlJND/8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajIKeu4s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712253127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCgQ4XKq9cQw6U/Q/+8bvsFn1ExQW/rlMWVpTGGhyWc=;
	b=ajIKeu4sQ0cF8cgTCZoF9mFU0msD3eKxcx/hu6WcULF6o0YNle7LPjVgEexwbCWVsUWbTB
	nW/2zmMNQduCGKb9joBqTpKjznp9zuNMolOV8ftwr0LJmBKY/Bbg88NvHRq2E9DRT8F1Fi
	D7hYDyIx9Y4fRXrWfCIhHVKDysYIeOA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-1cnSf5dCO8m7jK-R8JyHbA-1; Thu, 04 Apr 2024 13:52:06 -0400
X-MC-Unique: 1cnSf5dCO8m7jK-R8JyHbA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4dfdbdaf06so73489566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253124; x=1712857924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCgQ4XKq9cQw6U/Q/+8bvsFn1ExQW/rlMWVpTGGhyWc=;
        b=b7qmVOeY0NJ3dAGQhVtZ45fl0X+tFo9BNGxMAVMj/KfI7LfCWfs1u3Lxx0KVE+jW2h
         H+KABkZcHWbdzMmRL3UOf993Y7gPBENipa6afY0pxVF1DiGmCgKje9pd4Z8+nED/174g
         fRiNrhgvDev1ubhY6WMPYdiYLKG9sppANoFrBYMs70INZKXCAFgOzU5QU7lzkExxRNjV
         vTYoweKFwR8oCIN8x2cXp2i9NWoyIWgwUpK7NG0pRQr6ljRurzP0j+1F0VK99y92bB+c
         orsUgFVOZLFz6HeeZFXgi3vhy78MgT/Qg/sPSm7xUkfTQSrYubUm8i/e42YlLAw1BbZz
         A+xA==
X-Forwarded-Encrypted: i=1; AJvYcCXY+du5c5yt9I4Vg5S5Wf+QDbkFkzDOucUpuwFROwFjJdj9ppBYGC/I0h3jZ1z/cOr5lqsTTBA5mbxbucFbut9nPHb/eV8WIUULSCMC
X-Gm-Message-State: AOJu0YysHlg4HfsAqT1Kq5WKPsa7T3YocsFAnYB35/nEj8IdgAjTvcnQ
	RuIDJcQmt5K//y/a/7kmO6Ne3NcxzcmzrC1668VylO0tjXpAuJEAESCu2BH5R1xstloppFb6tcx
	cwwmvcNRMnxh7dbwMxgzwd4k7/jL9RgYZBz+0QsOx2pY1xMHlDimkhUQSmWJooRwu+Qk79UTy
X-Received: by 2002:a17:906:ca53:b0:a46:f69b:49b1 with SMTP id jx19-20020a170906ca5300b00a46f69b49b1mr2168038ejb.46.1712253124502;
        Thu, 04 Apr 2024 10:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECTCZS8Nnj41N9h41glDkW2rAddfgIewt7568b2jxlvfUWxQkRUr0YSWIeeGYuEacqzP+zEQ==
X-Received: by 2002:a17:906:ca53:b0:a46:f69b:49b1 with SMTP id jx19-20020a170906ca5300b00a46f69b49b1mr2168026ejb.46.1712253124181;
        Thu, 04 Apr 2024 10:52:04 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id q17-20020a170906145100b00a4519304f8bsm9424868ejc.14.2024.04.04.10.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:52:03 -0700 (PDT)
Message-ID: <36bee1ae-e9f9-4ca6-917a-6f65203a7e96@redhat.com>
Date: Thu, 4 Apr 2024 19:52:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] sched/core: Clear prev->dl_server in CFS pick
 fast path
Content-Language: en-US, pt-BR, it-IT
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-3-joel@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-3-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> From: Youssef Esmat <youssefesmat@google.com>
> 
> In case the previous pick was a DL server pick, ->dl_server might be
> set. Clear it in the fast path as well.
> 
> Signed-off-by: Youssef Esmat <youssefesmat@google.com>

Makes sense, I added the code to the v6.... embedded in the patch it fixes.

Thanks!
-- Daniel


