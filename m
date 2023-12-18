Return-Path: <linux-kernel+bounces-3513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B245F816D33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614BC2810E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882E837D37;
	Mon, 18 Dec 2023 11:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XbCbq/EF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16146358B9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b406a0fbfso2214958a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702900500; x=1703505300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/ZTRFB8KMknyEn1OANya2XOBJMhR0NStgi+5UdJh4Y=;
        b=XbCbq/EF1IAH8jBw/5vLoAebO1maIBGoBzBcdHfn6XBugftWPaP9Ul9WZwJm1x56tp
         JFywnvqeJC6NiRGS2k3JC9uEp8lOwP+irbDj4yquHBQQFYQflbKql+vVVm33NnV7bPwp
         LHmOBD/np0JIPBzJya7BSnnhpXiSiwdswJqpKNDig/49Z0M0c9dAjeY1XGyWFD9gC2L7
         MqDPfmXikK+uRT9y97gTY7y8Zf33xEU+0nA42OVpC4IIt/ovHioIK2MAbPdeM9espD6f
         T6TjyvBdlq/Ze43VtdX1nYZOoUILZN5mjYFhYTccbXhpaoqV5jDaNGcAuAvkNYalGnMj
         e9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702900500; x=1703505300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/ZTRFB8KMknyEn1OANya2XOBJMhR0NStgi+5UdJh4Y=;
        b=DCEpLLZnA/0POsWD80k1j6lXwDRjD9jcXAFGvoFNlqHqjqjH44zBZ+fOymYHZQseCE
         3YO3U5Nka3GKpBs9kOl85On2dKgTymeqIMfKv0YGGs6LKBTVgxVbT7KGBq5VhzN7JRbg
         EsXxxPoF3vEVccklBAOfmoEhZsaFIdjZ+wHPtEJVeg9IRbh8r2pl+4naqKn/PD2w130C
         IiYjo9z35FSqfale+ypZERsXPkMd8Otv1HyOZNOhR/gRXPZNxkx10hwnSTGaHcne58em
         SED10l7XiE1x37AG4IR9Zmze5ubRJW5p4+kppWl3tjkoZ/7lwM7yXC+D0CmZMFeIVdGk
         ynPA==
X-Gm-Message-State: AOJu0Yxx/f3sNRmiCTMyC/fAPtUxeHpFk7XcPSydwUVjlFCeoCBg91rU
	CwEYboMYJcEKIX45+u2gtTvtGw==
X-Google-Smtp-Source: AGHT+IFX+JEJt0kMbu4r/pT+K+Ae87LI+JcegzzYIsYDypkQbvs0634QI0zRFUUHW0FedU0ubT0K4Q==
X-Received: by 2002:a17:90b:4b12:b0:28b:6d24:be81 with SMTP id lx18-20020a17090b4b1200b0028b6d24be81mr801108pjb.55.1702900500392;
        Mon, 18 Dec 2023 03:55:00 -0800 (PST)
Received: from [10.254.38.164] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id qa15-20020a17090b4fcf00b00286da7407f2sm7602250pjb.7.2023.12.18.03.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:55:00 -0800 (PST)
Message-ID: <27c8af2f-c931-4d36-9db9-112de79ec3cd@bytedance.com>
Date: Mon, 18 Dec 2023 19:54:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] mm/zswap: directly use percpu mutex and buffer in
 load/store
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
 Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Vitaly Wool <vitaly.wool@konsulko.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
 <20231213-zswap-dstmem-v2-6-daa5d9ae41a7@bytedance.com>
 <CAJD7tkZSrd-R-vuVqh29fgZ6bmo3EJxdb2Eahm0Ozg5hkPEjRg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkZSrd-R-vuVqh29fgZ6bmo3EJxdb2Eahm0Ozg5hkPEjRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/18 17:37, Yosry Ahmed wrote:
> On Mon, Dec 18, 2023 at 12:22 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Since the introduce of reusing the dstmem in the load path, it seems
>> confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mutex
>> now for purposes other than what the naming suggests.
>>
>> Yosry suggested removing these two fields from acomp_ctx, and directly
>> using zswap_dstmem and zswap_mutex in both the load and store paths,
>> rename them, and add proper comments above their definitions that they
>> are for generic percpu buffering on the load and store paths.
>>
>> So this patch remove dstmem and mutex from acomp_ctx, and rename the
>> zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
>> the load and store paths. And refactor out __zswap_store() to only
>> include the compress & store, since I found zswap_store() is too long.
> 
> I am not sure refactoring out __zswap_store() is useful to be honest,
> but I am not objecting to it, it mirrors __zswap_load() in a sense.
> However, if you want to do so, please do it in a separate patch from
> renaming the percpu buffers and mutex. This will make reviewing easier
> (and make my Suggested-by correctly scoped).
> 

After thinking twice, I dropped the __zswap_store() part. Right, it's
not much useful.

Thanks.

