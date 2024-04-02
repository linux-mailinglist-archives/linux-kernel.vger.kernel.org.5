Return-Path: <linux-kernel+bounces-127695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1923894F96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CB5B21283
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E75A11A;
	Tue,  2 Apr 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOqjjlOK"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082259160;
	Tue,  2 Apr 2024 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052556; cv=none; b=i30KxEpupOAXdXIjve7vsHfI2iWPI2s9zV9bgMZsFomU22DfENlaRzrnVp5naSmHLWS8Kx/3QbBq5Wo2308SnMHJ32ikRKrXqTBVz3lNQ33TfmaysxULmHSYtMI9CuBGYhGpB1WM3oPGUfOSE99uz0VBsyG2tgtHqLzgrvJBzzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052556; c=relaxed/simple;
	bh=JryuocXk4oPPa3Vuic+FPW/lgf6R00IGoiiOeEOwEwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUmA5E9LqT99C8aQLDlzsSVqDNODUkdB+O5WkwbLBLeLdMb6hwlf6uBXYHmzvQkkyv/qnP1I8Bhmg0Zu2mZhXd7SHk0pWxL5Ecl+c2v9KgOFmqDqf0ddG6SkJtHa43IjD36MdAq4EHYO575L9JEjgCkx2EYQDOrtB8b9EcDM/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOqjjlOK; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-34356c24701so394496f8f.1;
        Tue, 02 Apr 2024 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712052553; x=1712657353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JryuocXk4oPPa3Vuic+FPW/lgf6R00IGoiiOeEOwEwo=;
        b=SOqjjlOKfokb9SBV1zRE/kQ5EBkd1zsowuz3jj+WZVm6eZp3lFPmrArGl5tHW8UcJJ
         5WL3CkUNniLBSPMY+7L4uIAdTo9//NGVqq5yofarrDkjnNjkL22K1Eo2ZQ8CX4ewkT8O
         6ZJKOP0TFj4gdOlmKwcilpQFjgzC8tZVNZV0IjFBKHyf70GOWx7eoIJQOPyt041qIWrG
         bSa8Bdo5KdAw5e3WarkVVkkefcIvMG36sek/ohl/B5kjxQjDWcgYtpHsIks2MA/S8/9m
         I7620fVGMt8zl7XL0InKcs8/urBc95bMq2g7Ac+1lJHRFgJxSQA4h/9j2Hnpm8W/SDQI
         MMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052553; x=1712657353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JryuocXk4oPPa3Vuic+FPW/lgf6R00IGoiiOeEOwEwo=;
        b=DBgoaIMO7UYlpBPgWMXTEaeZR5sRkGlqdp6v96xWJeTjuMTuEoxiq84R6Pr9etztv5
         UXcrD4eBliRNjX4DHXpXaIjUmI9xHwnHo0FGzYghfRXTBpyRcwrRL8Ogf6w8zQ+20bGp
         KX/2/uVoIIeA8KggyPOfqp0yLuVhgyepOvg7CtOW5GLc0nqZdWARu+PwSF1VwEM5E2hb
         9x7CA7sNIG+I5j2kj8RyCLM3Tfs/y838Da9SOSV/pX0GmYqel3O1SdUcYAfNl1abP4Uv
         jyE4cAGEu/I7aJNweFPsOkZwoM6ODPGGixw9+pVpcWn+nu0A3YGSlmItIo2qN48vjXFx
         G8XQ==
X-Forwarded-Encrypted: i=1; AJvYcCW188AUWY+9b5Bqe4TW9M4oINMKKjEdPgt5wkvPx9Ihcx+QIXqkJQ6s/nbeVkS3/xeflZtR1c8MCia4cQfYA1KAE0Z/HborNeqEvhkZ
X-Gm-Message-State: AOJu0YyHcVTKB33qqoukl0xC1leC60gLwR/kmilghD49/b8Gu5lKwa85
	8K/+vfW22tjMhmHYS9denvNz/57+S9qHArULf5Cg27Ur7wnIcQl0
X-Google-Smtp-Source: AGHT+IFEFy9jloJBUutYM+hw3YQRTbz6Yv7la1kp40XMb8F7R5K5reSa30pcVViGSUKisc9+kOHfiQ==
X-Received: by 2002:a05:6000:2a8:b0:343:4c66:9a26 with SMTP id l8-20020a05600002a800b003434c669a26mr5402363wry.14.1712052552955;
        Tue, 02 Apr 2024 03:09:12 -0700 (PDT)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b0033e91509224sm10975328wrb.22.2024.04.02.03.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 03:09:12 -0700 (PDT)
Message-ID: <4bf87e9a-71a4-4586-a112-43f8ce20eb46@gmail.com>
Date: Tue, 2 Apr 2024 12:08:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/4] net: route: improve route hinting
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307171202.232684-1-leone4fernando@gmail.com>
 <9ce73c04-ee8f-4aa5-ab15-c31dbe409401@kernel.org>
From: Leone Fernando <leone4fernando@gmail.com>
In-Reply-To: <9ce73c04-ee8f-4aa5-ab15-c31dbe409401@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

I plan to continue working on this patch, and it
would be helpful if you could share some more thoughts.
As I said before, I think this patch is significant, and my measurements
showed a consistent improvement in most cases.

Thanks,
Leone

