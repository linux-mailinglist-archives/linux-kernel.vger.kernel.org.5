Return-Path: <linux-kernel+bounces-100592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E68879A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0598B1F21C72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E41384A7;
	Tue, 12 Mar 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bKV79gVN"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B7137C3A;
	Tue, 12 Mar 2024 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710264072; cv=none; b=BDmbmfXOpacGxz968TcUGmuFUw+sDevv0SeAQ1UGhOS8gHEc4NGOG04gxx5NT53l8Yz6Tcnh7EI+2lmP5Cs1LnyJogu3XN+YYeCYBZup3jrtX/kTjq+J4wLNT+DARDGObhZaWUsqGNJ1nVeG8oUcV58rdOdYUpaH9u5M2mtAa2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710264072; c=relaxed/simple;
	bh=6V6GW1BvyQK/faDNyVxthxDLtscWzzjZUS4ESvRtIpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tpq7lXqgNdJnG4ETfxWONgSZ0/g5RfPH+Ow0FrPK18TdzDHF2ElsRlsksq0pEuktycI5XqGp+NKUYvi5AwOT7JePUXZ9j/EW0cE5jmPklGdmlcDm1DYgBTO9zzN307T8+CgZ95AY4SunfCOhnaYNOdUkbtU2+5dSTdXXr+MvuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bKV79gVN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd10ae77d8so43862105ad.0;
        Tue, 12 Mar 2024 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710264070; x=1710868870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbzYizPrcA31r27IhlGfXYPRToUyr5sIrzzrrp+vlHg=;
        b=bKV79gVNlxT+6CeoDuC7AtYeapFBanaVauubQYtIuDA1wueT9ddTD6yfxDPaFlzvWi
         SLP0CsTtLLHcPLPUViBJwbdoTNSGzVl7SVyFesUxR2Dq4PZEJx+Q40iBQ+AFNTqeR4B8
         pgSuQOn01FQTqd1w8d6YiXPCxt0f9hJmc3pDuL3QJDmqjZYuuEv392Ywo4tP8sUN0gLh
         GVDg/Y8VKeaeekMOSHfRj0c8UWVBhC30mbFLbR4GRzG6wTogoIArBWwTGMcqtDu5Feek
         s8yAKnZmxudYOZz/3nm6MPnbJhO9bv2q7osHPphspcxWkyjty8nKpe7zuHymul8bhWCo
         0i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710264070; x=1710868870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbzYizPrcA31r27IhlGfXYPRToUyr5sIrzzrrp+vlHg=;
        b=AbemwH3mev7lUf0d6+4ID0mMFYLmAFWtOV53SwSpfZGzRjt4SD3+kHmcKm5e7F7sKo
         UUP4zfnVyUntSDEPM7UhkmpldkGmoDdVgwKDJSj2WcWo76VPWnbpu4MRzTZDuQ7L/CBm
         HLfXOTYv0QAtrafKjOqsc7qghjf0nOeM/WTPy1eMyJHYuhRLk/jRhXxdbh1zFGJMFBHG
         pi6eROe0SsSApgnlozfzYFXwkqq8fkFrR0xZXZvsyMBGjj50Wmi0hUf+NcVomzPz0qfP
         cWu4Qj/oSHbBY2kt65vXipgw+wnwqhfqk8WTNhq72XVh6kLbKrn5i2w8226+9mVpS1S6
         Iw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgM2A5GBreFR2mifHBZ060JLI04pQsFgCKzGt+/r0n47ZmsfUNPVdyna1QUdDMxpoliSrRS0mORI/f+kvfJMNMhSMjHljHlyP2N/Xd00mRNRDWZEy7p+7zRlgiaMbvym7FANQNNByKaw==
X-Gm-Message-State: AOJu0Yx916JsMv24P+KDO65+q0IFFS6wZaW/XMtGCpePMjS78XLXRWWx
	DWJo8aR3Qgf1MJM5yBzWIl+18lNZ5xol5XUjpO6ljoNTbGbx/armN0M1qlY65koGgPS9vN7219E
	lW71JPm6R0QBnX6MnEw5jhyx9nt0=
X-Google-Smtp-Source: AGHT+IGbu3in/CKHQtuChqNrVACfSVFLlMyrSjQJ9lpv588lBvl8onmp+AGlxEmJDhJDIS0HIA9ruCBxORmovg9TRyw=
X-Received: by 2002:a17:902:7ed0:b0:1dc:de65:623b with SMTP id
 p16-20020a1709027ed000b001dcde65623bmr1927169plb.60.1710264069927; Tue, 12
 Mar 2024 10:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com> <20240312-basic_dt-v1-1-7f11df3a0896@amlogic.com>
In-Reply-To: <20240312-basic_dt-v1-1-7f11df3a0896@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 12 Mar 2024 18:20:58 +0100
Message-ID: <CAFBinCBiCoOY7wK+8j4kNZwny5LFTX99PLk03gUvqnGxJXgvEg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: arm: amlogic: add A4 support
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:19=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
[...]
> +      - description: Boards with the Amlogic A4 A113L2 SoC
> +        items:
> +          - enum:
> +              - amlogic,ba400
> +              - amlogic,ba401
> +              - amlogic,ba409
Within this series you are only sending a .dts with "amlogic,ba400"
What about the other two compatible strings?

