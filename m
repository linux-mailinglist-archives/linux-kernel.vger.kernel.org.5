Return-Path: <linux-kernel+bounces-46713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F9844310
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19EB1C21EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF512838F;
	Wed, 31 Jan 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG11al+h"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F269D22;
	Wed, 31 Jan 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715064; cv=none; b=MPAXJAM0kadCNtdKKW098vI6DEByAUQalfCEVAsE4aPlyTbgCCQjtKmbePkUfmVRAq5BdVsa06ND7IxxOZQWN6847SbdDJgO7802fOlrdZEGWNWvNdDn+Mz2iS0ZXN9Enf3f0LEzrTTzmyELkoBLgISNszt7PY1fFUL3av4k4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715064; c=relaxed/simple;
	bh=jt6rTQs4lkA/V5LXFaYBX03W2WGr3jScdnIgbJsi/4k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uzqFdxqo8N6BwDq0hjLx32wK9wcSH6zdV+M3DDgoY44GIIghTNPgqWLXKtmR8p0TcVYNyb1/aD90s1nFVLEvwyKBs1hn+E+FomR9/OsnivLTmnxcu5usbfgI8x6kjDY0Oc9IdAw4EL36WWuDAF9LPpXk+EybcYGFEj0TvRMz53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG11al+h; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55eedf5a284so5029205a12.1;
        Wed, 31 Jan 2024 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706715060; x=1707319860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QlWx7HbsDcsgBtZeaKhN54G3HVuF5sErfrGgXe6TcXk=;
        b=FG11al+hbN0iZYhWHYgOOx9Cg69hGTYTFSrIV9K7Z+TdrACiigJQEMsKBPMdDTHMwN
         fZCZBQT9Xs6kDVftYb9Kubpl/zKEwKxQkQL9KbCLYHgV9eJ39hGvPlwEPQR2qVSqAn2A
         3lstKOkeP+YVlCHY5Gr2qlMoQRAGPheMbcpBeF1szfl1YX7qNEsQQA4+jvOMKkn26S8+
         WwnczsBoTEQZVDhNMCsmghXymWCH5KVVtyF6yDoG+icVOYqwCnfnWAPYmqsCUme1I3xG
         CFc+KFGhL3/3MyyYCt21JuKFtN3vebYLclRBE/Z689tsrpaeqhn+bYVX9Ge8ZXJDqPDO
         QMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706715060; x=1707319860;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlWx7HbsDcsgBtZeaKhN54G3HVuF5sErfrGgXe6TcXk=;
        b=fIlvOLO5ns2TBaBk/Q8yEOwVng2qltqbKBMfiOx3Quhi+75zDDa4xdHEC7Vo5pEsgy
         HKek8XsE1HsDErO6Q7H2e1b3CMgx1ZhWlzmazviHc4tow3rU50e0A9t8sc/24G7g+ALj
         SGE+aKb5I9+uAmMt4A3zjHLpHhXAajFe7cb+OYSw4F/GOjv504n7U0rBkeQwMIt3YWOk
         qjSrf3Zap1zFvqpEnUq3W/B75wJKe3B3cGaor1twyUQRYJohbxpj17kaa5XOEUgDbyyJ
         bEcFFgEoeB5Ih83hT8aU8OF5F8OhjPYQLtMuZrRNv5Ht8f046iz7FjKlz9YYQ5EnsvLv
         FDHw==
X-Gm-Message-State: AOJu0YymINhlPGVGLdL7cP+1ablUPzBdbNj0p+/F2dzLr9Eii+UowlzP
	/dnUT4OLV0qyw7ZUg/+OQxaLD4xavqIQwIM56ROUMK8a9NY9X5mC
X-Google-Smtp-Source: AGHT+IGKx0xLRBg/SwHW6EiKGSOERhU7QFclNM0IJp8kiIpCPE9gkB9AjQ6vSQNGPtXKqqdNo8lG9Q==
X-Received: by 2002:aa7:d6da:0:b0:55f:3b8d:769a with SMTP id x26-20020aa7d6da000000b0055f3b8d769amr1345628edr.19.1706715060428;
        Wed, 31 Jan 2024 07:31:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWH8adZZ7ddW45DLYparKuIhnR/QncTIZg4AhB67HorXPKC4hOqgEj0rLmOB6ZlBmyN6YReouAYCgRxtHWgot1qiWhbCXuyk34U5zrP0I0A0/jcyYopY1rl8pj6m5SIk7GUBJG6Z07bz6ggGDstpFcfJW18mopqq1uqCSfYGVLFlQAg72SHEW84x/mSupevTd61T41K70EWtbWeF0RnTGjoPtWzdjgU3TL7QPy9Hi5EuiBhq5Umy9aqEcCQQNbOc3+QamINOnsQUsryz4vgxQts8amrRSvf7vd1VxdPWGV8RCzJPZtk+LaOxW4zHI3R394Pq9V31DhlbbVt420Qa2IUhKd0w/zuQv1QvF6OGWC7GoTYgoq74EK/5mQFHio8vbmTYsxTV+ug72E=
Received: from [127.0.0.1] ([46.211.116.2])
        by smtp.gmail.com with ESMTPSA id q15-20020aa7da8f000000b0055f49d558b8sm1525064eds.23.2024.01.31.07.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 07:31:00 -0800 (PST)
Date: Wed, 31 Jan 2024 17:30:58 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kees Cook <keescook@chromium.org>,
 Maxim Schwalm <maxim.schwalm@gmail.com>, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/4=5D_dt-bindings=3A_vendor-p?= =?US-ASCII?Q?refixes=3A_add_LG_Electronics=2C_Inc=2E_prefix?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240131-elderly-passover-341b89f65189@spud>
References: <20240131105153.8070-1-clamor95@gmail.com> <20240131105153.8070-2-clamor95@gmail.com> <20240131-elderly-passover-341b89f65189@spud>
Message-ID: <656FDD69-D7B1-4910-B848-108CB985AAAC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



31 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 17:28:49 GMT+02:0=
0, Conor Dooley <conor@kernel=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
>On Wed, Jan 31, 2024 at 12:51:50PM +0200, Svyatoslav Ryhel wrote:
>> Add missing LG Electronics, Inc=2E prefix used by some older devices=2E
>
>Is it? You're only adding these devices now as far as I can see=2E
>

Hammerhead (LG Nexus 5)

>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes=2Eyaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes=2Eyaml b=
/Documentation/devicetree/bindings/vendor-prefixes=2Eyaml
>> index 309b94c328c8=2E=2Eb94ac977acb5 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes=2Eyaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes=2Eyaml
>> @@ -767,6 +767,8 @@ patternProperties:
>>      description: LG Corporation
>>    "^lgphilips,=2E*":
>>      description: LG Display
>> +  "^lge,=2E*":
>> +    description: LG Electronics, Inc=2E
>>    "^libretech,=2E*":
>>      description: Shenzhen Libre Technology Co=2E, Ltd
>>    "^licheepi,=2E*":
>> --=20
>> 2=2E40=2E1
>>=20

