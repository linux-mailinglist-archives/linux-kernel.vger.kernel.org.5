Return-Path: <linux-kernel+bounces-81313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D601867414
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D0DB2485A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517075A795;
	Mon, 26 Feb 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL4J6oxs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A45A0FB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948435; cv=none; b=MMfTCijpdsgUL8A2hkwcwOPx93ft86A8mpWh/WAcgurxlbrgCYlJ9+scN0GlFuSugO8wTxsCQ4thOPYToJBdAr284DLbzF4TLx8pvXuhakjDuaxpWZ+Lv10k5DUMum/w7sazR8fAMQ0+VA7lU7LTc9DjjakAGb9wewWRnqbIUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948435; c=relaxed/simple;
	bh=ubN9jpbxnUOn3Nf+SSQIPfdxnodeJtVUj6aPzJVKrDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bvo61XBprP+vGrbHUHYH/GgqlZSgCOw45TAC6K17en5mE8ufxd5uqQ9lmSS6TLnp/5rSxbb81kRp7kphrX9FkD9mgjFZE77ovuP++jyrt93R/W4bgebhpouytZ/nsfI9lRqT0IHf03mE7Iwu7YjR2Fdfo+8s/i/9YhM5UDevie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JL4J6oxs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708948433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=N83wWYshCUb0OAMGltLJDvm3mvy8KKu8gtewNQTz+Us=;
	b=JL4J6oxs4wy5RU75dtWLYJNTCm2EbEFfcBs9ya+FsBqWpaUvsgS1cdghekpLIfSWth75J2
	+hn0JLoUjwmGpZ5QENaqoLtv24ObjhY5h87t8v0LtB5L04/sc+dfVR4Lp181Q+mrxjGx88
	d/c7T7/iQcUvIj6mpiIhBU80vxUOPs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-dV1qGKaUNv2gFzear963Rw-1; Mon, 26 Feb 2024 06:53:52 -0500
X-MC-Unique: dV1qGKaUNv2gFzear963Rw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-412a070d81eso3131475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948431; x=1709553231;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N83wWYshCUb0OAMGltLJDvm3mvy8KKu8gtewNQTz+Us=;
        b=gYXiQGkp5s8ZHANmpJOV5u85nFtzgccFDSrVg4lmCR9NEuNQObU2trPUWhSGPRE0q7
         YOkjEqQ1XsgUpnEOOq95hSFxi0y9S8SwX61OAcdDc1bSIO70YeIOvF5sdFD+Vo3EPGHA
         hlzfWz+v2PR+SwYKPU8zJkMCW3NoatU5pv5lFHsyypMf3KmE4Gid44d7WeuE13afRnsF
         EIggq3Sfi2ajHWukkdtnpHjdPsVzAyljENFMsuWniyVZJVWB3kxfwlpsh/b55FittCpd
         caMcweDbA3yGGncfrwfn9kBCQVxBzgd6+CFlNrh8bhbmx5pDUV9zkRzPnPA9B0vFCYjc
         RySg==
X-Forwarded-Encrypted: i=1; AJvYcCW2ymIDjfBFWbVn463dnOApt8VIprpJzhPS3yHgzpZOi/7PIejs2094DLE6gu0kF5pgOE7lkqIezfGpgs+PLTZMFnpdst7TRXYzQ9NG
X-Gm-Message-State: AOJu0Yy6BkDB6jo7JoyO1lICdgQOc52T5jH6BnIJklBlrtA5+8t5mStB
	mvNL23IrtYc1iq/h0z4EA9lfvj+TolGWlgtQXDu2WDmC9y9AD6Fs27gQcXqH7o5/42D74aMg0jl
	LUqc26tFFZahfHqKeQjXBjMfnXmtOFJjbFvmKGGlomKj40XYriichcZB9YaTn4Q==
X-Received: by 2002:a05:600c:500e:b0:412:a96b:9aaa with SMTP id n14-20020a05600c500e00b00412a96b9aaamr43255wmr.30.1708948430808;
        Mon, 26 Feb 2024 03:53:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwx+LSotit9GJsq9qeYONBhWJ0/Lg1vAqPd5z55NBn9kh7O4AFmUEDRgN2C8LqQLgCU6TDMA==
X-Received: by 2002:a05:600c:500e:b0:412:a96b:9aaa with SMTP id n14-20020a05600c500e00b00412a96b9aaamr43234wmr.30.1708948430442;
        Mon, 26 Feb 2024 03:53:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:f700:104b:9184:1b45:1898? (p200300cbc72ff700104b91841b451898.dip0.t-ipconnect.de. [2003:cb:c72f:f700:104b:9184:1b45:1898])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b004128fa77216sm11727858wmz.1.2024.02.26.03.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:53:50 -0800 (PST)
Message-ID: <2f4c44ad-b309-4baa-ac21-2ae19efd31fb@redhat.com>
Date: Mon, 26 Feb 2024 12:53:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 19/35] arch/mm: Export direct {un,}map functions
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Will Deacon <will@kernel.org>,
 Quentin Perret <qperret@google.com>,
 Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
 Android KVM <android-kvm@google.com>, Patrick Daly <quic_pdaly@quicinc.com>,
 Alex Elder <elder@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Murali Nalajal <quic_mnalajal@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>,
 Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
 Carl van Schaik <quic_cvanscha@quicinc.com>,
 Philip Derrin <quic_pderrin@quicinc.com>,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fuad Tabba
 <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-arm-msm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
 <ZdhEtH7xzbzdhS2j@infradead.org>
 <20240223071006483-0800.eberman@hu-eberman-lv.qualcomm.com>
 <Zdxwo0abvklfam-Z@infradead.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zdxwo0abvklfam-Z@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.24 12:06, Christoph Hellwig wrote:
> The point is that we can't we just allow modules to unmap data from
> the kernel mapping, no matter how noble your intentions are.

I absolutely agree.

-- 
Cheers,

David / dhildenb


