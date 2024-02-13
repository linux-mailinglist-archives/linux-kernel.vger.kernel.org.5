Return-Path: <linux-kernel+bounces-64320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D2853D00
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FBCB28A53
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77A6216E;
	Tue, 13 Feb 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="x67UoeTO"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38E62147
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858691; cv=none; b=JZ/BkKBKOnD5+GJVOFnXVSVa+QJM0gKO1M0AklpGT9iGjsHBxsbx8QM21jsLDHOMBctnIkZXLMu9iXofah+hZ/MOTsfolzbLYfc+1q/S0j5jZyR70iXEeD6iLHsW1uplXb8L5ObBzojXNX9FDKUsrQfZprfdS1oEWS4dqTk0T7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858691; c=relaxed/simple;
	bh=URcNZyD5kEz8zJDL17XfbpEiOUzTp0J8ssDHqmdEsoc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TR2kQgEYEBkN32WZ9VoFPVt7Wlo3qRM/7WFOqBK313cGtY7Zko61KFJM/+7AuJSb3m74xivCf3veHQ8FxpqguVYyRK12VJ6pH4c8TMQfaJdK3x3RcAQzUQtbDCwiojzjL9vvZcXs02zV470e/Dnmx1ehYnHYQwwFiO9qEfyqXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=x67UoeTO; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c03d475b63so1318337b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1707858689; x=1708463489; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URcNZyD5kEz8zJDL17XfbpEiOUzTp0J8ssDHqmdEsoc=;
        b=x67UoeTOT2+rQAprfs1xJfmnRbpyGUvxCn3EQWQLmwwTqO8UtKbSAvldDiGkZTiWiK
         34Cb5zeLSL5YvyWgTOzSzDpoj1vD77pqvv3Fkpdt4/DKjNVdStUhOHjtYMuKQulyPbeJ
         ALOCvR5dVXNw++74h848/lROfrUiD46cuv9Tn2J4N+R2U70oRuaGs6cXyIJHUrdpvOqm
         FI7EU+AbE7vZ5hZefmnAUcuV18ZL6/UqhrFRd2SvC4lSjrmgCF+9zKFyN6uHWycvX2mu
         4dqzR72lrHPwvGG5jMolKywhpPPkCeIqo0988UK0bdeBfU3agD+Z36RGWz/1wxdaYoNR
         1+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858689; x=1708463489;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=URcNZyD5kEz8zJDL17XfbpEiOUzTp0J8ssDHqmdEsoc=;
        b=cr6/8amw+im7N0qR8ZnCS0cbP249ztVj+CI/cxkQlLfwDhfUhWp/HCUIC0D2YHaW95
         DrA650X0EWQVDITkjEpQjk1vT/oRFsu9Miq64tpGpkqPzDmvSa45xfl+DJ6ru4DchlOs
         4DIPVBDHQcg9sH1WI30hApqSxBsd3i5qHLbHxRvXUB9h/SCNJvW0PnJFZrswGyjdk+1t
         5MralAw4FflnlPq1jjyaxB4N5+grbGXIKm3KPQA9N95e6I5NsHTvhPrIF+Ey+HOZfcd6
         uRRXeMPX9aFeKSzcqkJMetqdtcWzgeRKh1KNNBQRrK8+pehvlrd9BB2y3iitzSiu1bDg
         gvLw==
X-Forwarded-Encrypted: i=1; AJvYcCUWdo5p9Q/D8mz8sYPoZg1ok63wyijfKDXw/C068Y4v0+HJhNqNN1Bp0aqQsqvXelODgneHQ7zxFSsENkKfCuf7hU8sZzU04noi6cBM
X-Gm-Message-State: AOJu0Ywc6gJMFi8UQUqOrGbPdddquu0AsfT0VNrpsCcflxKvH2HIe5HJ
	Cym/geELF4Xf+IMY+IchdOTzZKNukQlraOag46Drk1++9tU4MDwRSaxaoB1zOW8=
X-Google-Smtp-Source: AGHT+IHr8it3qPfWUxL0OEQG2S7W04F7kyQpaH0MYHN6wdK3WnRYxYbq23lvoqReFnkR6SLQvw9cjQ==
X-Received: by 2002:a05:6870:2105:b0:21a:58f2:a5fd with SMTP id f5-20020a056870210500b0021a58f2a5fdmr564102oae.14.1707858689141;
        Tue, 13 Feb 2024 13:11:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/Q2SwwZmqo0d1K8g865IRwMkWI78EHRIsyNbCouk0FR9wNN9u/wGDVnnunQtc/KVFOvhERdUytZoKYnkXD20C63hNwm0s6Kqxp+HH8GyYrGFlWy73Vl/uWpVBvdRjMEo=
Received: from ?IPV6:2607:fb90:e680:45db:40d5:ddff:fe3f:4ebd? ([2607:fb90:e680:45db:40d5:ddff:fe3f:4ebd])
        by smtp.gmail.com with ESMTPSA id t19-20020a9d7493000000b006e2d8b5d9e5sm591148otk.21.2024.02.13.13.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 13:11:28 -0800 (PST)
Message-ID: <162ebbd7-c319-ac29-50ba-c36c438c44e9@landley.net>
Date: Tue, 13 Feb 2024 15:19:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Tobias Klauser <tklauser@distanz.ch>,
 Christian Brauner <brauner@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Rob Landley <rob@landley.net>
Subject: sys_tz is not namespaced.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Re commit d95debbdc528 fixing CLONE_NEWTIME to work in clone()...

I note that sys_tz in kernel/time/time.c does not appear to be namespaced?

You might want to at least fail trying to set it outside of the root time
namespace. (Line 186, unless security_settime64() is already doing that?)

Rob

