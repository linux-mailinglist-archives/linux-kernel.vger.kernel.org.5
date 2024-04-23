Return-Path: <linux-kernel+bounces-154968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCAC8AE3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8061C22A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CD37E79F;
	Tue, 23 Apr 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0v4Wbfx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF87E118
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871304; cv=none; b=NlyPA3AqA78IA3wDHT3E8bEC/SsGD1NUFIEiQmU6ymckg7WCYlPv3EIWyZcRSB3y1xJsLgbzZu+bfBbbESAP6NDoSr36SaSawYtSlN1rgo2pc7T8l+Rks9GVs0VWWiy3kvwn6W5/vreKAqYjLv9FvG5DrDKxc+5G7eRZ7JS0Rwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871304; c=relaxed/simple;
	bh=FPC/+A/W07/LPB/AsnyEcUqbJPV/dqND44/U5fYSxCk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJYqR4xrHrwR+ZZKs7H6JehiV6i36VRoZY8nLJa67JhdtJyMrE8LtTn1qVaxF/vAL85Zbkj5/MKCfe83GtvTLD/LsUD3+PKPkEy60KKpY7Ke29WkT6ydaBWUPXNunQXJEB4WHBMMXE0YdzsQC45C4Z4UvJmP4dOaIkESc9v/Jkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0v4Wbfx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713871301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MNrVKhziuzMI2zBVcw95ga79HUtR021DvTlMsoiMS+8=;
	b=G0v4WbfxWyfyL0gaphs4tNGZgLDuPmYn1F/EBf8rN/OB7KHrXIO28l0Rkp4uhz+U0sXVcC
	/eZohoVP+8Ck+dsvE8qtdUR5CVkxiXJ+FAdsxq6CE0bgAz7MEF2qNaWEQohVlPv810Y14B
	PwdrWlTSuXU3vVKU+4ePC7tbaf7MtXI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-3W1OhxAEMyGh0wwNSN1v5w-1; Tue, 23 Apr 2024 07:21:39 -0400
X-MC-Unique: 3W1OhxAEMyGh0wwNSN1v5w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-349a31b3232so734650f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871298; x=1714476098;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNrVKhziuzMI2zBVcw95ga79HUtR021DvTlMsoiMS+8=;
        b=fc9U9JzSbmz2o4aCuf49AkfaFwbF9EAm5mAukTT0bwfMs3zy+JwgM1TQLJfMvaGOUJ
         f9FM2QnrN7A0dNV4zr/l8uX5eKhOq+u2WZPbk3ieeCZ+KoxoHxEXMcau1AeX83vNEB3+
         r8V7EG4TeVY/Qk/3Q5GcVCSKzjYIVqAvAexp/x8vOqA3ywAN9uzK8FRE3g3RmnBx7IBh
         AguOJV3gf9FKAeQ3GDH087EOnTtOain4pmb5oGOyLIwPXneRI3h50LeDI28RtNBQOm6q
         /ZSUuk44tt6MVqhU43mQFaiR1buoyygiYVujfL2Ac81zkzern6LMgrDUqtiDCUB7htfH
         dVSg==
X-Forwarded-Encrypted: i=1; AJvYcCV0UKs7mXwK2ZpkBdglgN7jNvbLfSMtnHzrEvp21wYThxK3LPnV8QPNrPsXIALImqVT/RP3au4P9fnK3Uxd5aQMmZH8SN8vFg94iuuO
X-Gm-Message-State: AOJu0YyMhw0VT9pkmBLDnzGWL/RsAe/IHO7/lihLC4ShLM/xgXy3gjYC
	roUzKoG5s+L+aL4uxSx1aqAoBOcEc/Ez8XN2XkVC/5HWHNTf9/BsGxXdwYxAhLCUKVo6H0NOeo2
	BQ2iFBpoHTCRKSZ8ozrkne9uUk97ZOcANnYenU/IN5MLtUCE/29L86I8dmqh5nw==
X-Received: by 2002:a5d:6392:0:b0:349:eb59:c185 with SMTP id p18-20020a5d6392000000b00349eb59c185mr8337082wru.1.1713871297876;
        Tue, 23 Apr 2024 04:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRZrQIdtAdVqxweYR749d1ytwQmJBTSpPkkXtSfywePk0Gd+s8/DoFq4o+RnrozeutvVYdjA==
X-Received: by 2002:a5d:6392:0:b0:349:eb59:c185 with SMTP id p18-20020a5d6392000000b00349eb59c185mr8337069wru.1.1713871297474;
        Tue, 23 Apr 2024 04:21:37 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:172c:4510::f71])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0041aa79f27a0sm2700658wmo.38.2024.04.23.04.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:21:37 -0700 (PDT)
Message-ID: <3a09d8e47e4c59aa4a42baae5b8a0886925a94a0.camel@redhat.com>
Subject: Re: [PATCH net-next v2 7/8] net: ipa: fix two minor ipa_cmd problems
From: Paolo Abeni <pabeni@redhat.com>
To: Alex Elder <elder@linaro.org>, davem@davemloft.net, edumazet@google.com,
  kuba@kernel.org
Cc: mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com, 
 quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
 quic_subashab@quicinc.com,  elder@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 23 Apr 2024 13:21:35 +0200
In-Reply-To: <20240419151800.2168903-8-elder@linaro.org>
References: <20240419151800.2168903-1-elder@linaro.org>
	 <20240419151800.2168903-8-elder@linaro.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-19 at 10:17 -0500, Alex Elder wrote:
> In "ipa_cmd.h", ipa_cmd_data_valid() is declared, but that function
> does not exist.  So delete that declaration.
>=20
> Also, for some reason ipa_cmd_init() never gets called.  It isn't
> really critical--it just validates that some memory offsets and a
> size can be represented in some register fields, and they won't fail
> with current data.  Regardless, call the function in ipa_probe().

That name sounds confusing to me: I expect *init to allocate/set
something that will need some reverse operation at shutdown/removal.
What about a possible follow-up renaming the function to
ipa_cmd_validate() or the like?

Not blocking the series, I'm applying it.

Thanks,

Paolo


