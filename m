Return-Path: <linux-kernel+bounces-153038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B18AC82E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995D42833E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B451C5F;
	Mon, 22 Apr 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuQ7Q7V5"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC923A9;
	Mon, 22 Apr 2024 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776289; cv=none; b=O5Bp0Ru11WAJpydu3dgWE4kphZHy/tjOaDOKS4mnCtnyoM4p3xIZ1CuVcwXGs+oAm23SToD1mlfGG6ak1N/dYb85mqUS4N3BeixeEfvdOVSEtOoFyzPsiRGcaqsMho2vPWiomSL/9bGHXNjEqTeAospV8brGRCsjwvk/QeJb36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776289; c=relaxed/simple;
	bh=Ap3HX7usqppks+6r6AnE3+EOtHNtpTo0nvOHWkQP/mU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7UM74hJSJvt2+SLAIwE8lUJAXMKwJNoXDpPJ6oB2AzDU0OKco8lMQYzp+MJ/suBWq0gs2nUMeWTUhFRaBvsrTiqpdi23uuTXPb+ad7ZM2z3fsjOUlxyDJEjbz76JZ4I/Y04IKXJJlkaMEQE8iCJenlVNebOQEA5nvKb0m7u51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuQ7Q7V5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e65b29f703so29369745ad.3;
        Mon, 22 Apr 2024 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713776287; x=1714381087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDvNk3KFFi5iNtt67egvus9yTR8HOXf5HBSszFwHK/s=;
        b=XuQ7Q7V5B8F9ib5MTVV7auEYOudhll5uzNSQk5PyoG0vNV2AidK+PtI365IiJsWtWB
         wBrsv7V3SvGA2BMGSC0DC4DM55lxMlUmqhHvjy5shD9lzhHWt2pp7nAhn8PsTFPmrxq+
         Godue09A5krvaEnqH1CI1cr3V5l0aotwnzveuK3z3Ji65WtYQJUh5gghIfz4QlC0ZXDZ
         0Tvn8p7ehTA+oEGBJI9BRJ7lZwNnF40c/ArUDXSJiRyyECxnjZNPjm9S1XeCOV02P4oW
         VdR2umaEgF9nUaDhGvkZHxiFdoM4jdu+WvCp22XZaFa0hsW8IURzAmAuWhMwkjjSGdO5
         HIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776287; x=1714381087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDvNk3KFFi5iNtt67egvus9yTR8HOXf5HBSszFwHK/s=;
        b=nnrORwzQblXvduu9tZFUZW7jg3OchmpIqHqfKmr471z4xF3n+yqzX+4QrFQilFxi/m
         UNVXHu/6vI+ciNunOu0v0XGpOmM4kbJg9gkY1Le49VTx8iVxGhiZnS6MRHA94MdXokef
         JlMYJ2qsit0uHIpkoWOLlAgdu6TvYjpGB3EoSIY1MZH/JgvrysHEwpviQSaANwTS8Gu3
         xBgqQ1F49gYB9Qz02YCwrCvMH/4IZVBb+U3g8zAJ6QGHqXQASZa4TfL7u7At5Xaeeih/
         fT8vMGSV2AVrXmtfl0VIra6PHif2LWSZPSOuYNfHApRo1SU0YnIRE9AZq1jDA4wsbr/q
         8FCA==
X-Forwarded-Encrypted: i=1; AJvYcCVzm2GC2LZBgPDxakxkwn2e5FfI0razZh/7yv6t8ZF1J96++5thsAI3h6PXew6UYMg9jU3P4qQfKA2PCaIK9KmiOhjxsFO7FJqadOGzQf5SGCyvaAsl0OeEyvP9Qi3HCcvrw5wHdh5f44FLs6WyKKD2bHlzzSHL66lz+I6BxpCE
X-Gm-Message-State: AOJu0YzT4QUHid8VTtTbs8s+8iToq7Mc/9Mw9S46SBtVyvJsTU93gaYy
	IyntdYrrfu0CbGvfd8KWtRv7XVY6f/zAnAeutwR4P7SA8qU9xZHIX9McKpGgEDs=
X-Google-Smtp-Source: AGHT+IFiUKcQbEbEswqmEa7FF5Be+uhP6zbP7zIAy81U2IK1yxVzYtLaXWaUC0KFwf7R/8gd0wKAEg==
X-Received: by 2002:a17:902:b086:b0:1e3:e563:57ed with SMTP id p6-20020a170902b08600b001e3e56357edmr9149593plr.36.1713776287157;
        Mon, 22 Apr 2024 01:58:07 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b001e79072ee58sm7769887pla.62.2024.04.22.01.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:58:06 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jirislaby@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net,v3] net: ppp: Fix deadlock caused by unsafe-irq lock in ap_get()
Date: Mon, 22 Apr 2024 17:58:01 +0900
Message-Id: <20240422085801.140509-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bb5c1fd1-c3e7-4aaf-b28d-a45479ff0815@kernel.org>
References: <bb5c1fd1-c3e7-4aaf-b28d-a45479ff0815@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jiri Slaby wrote:
> OK, but read_unlock_irq() is not the right way to do it. It would enable
> irqs unconditionally, so serial8250_tx_chars() would not thank you in
> the above call chain.
> 
> Plus the issues Jakub had with the patch.
> 
> And what about ppp_synctty?

Hmm... If the problem is the case of calling the function in 
serial8250_tx_chars(), I think it can be solved by continuing to use 
read_lock() in ppp_asynctty_wakeup() and getting the ap by not calling
ap_get().

If I do this, will I be able to apply the existing patch to ap_get()?

Thanks.

