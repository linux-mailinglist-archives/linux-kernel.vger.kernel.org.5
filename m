Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7E67CC919
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJQQvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:51:18 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C8792
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:51:17 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c4cbab83aaso3941386a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697561477; x=1698166277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzS/0bu5CDxLhlB0/9StVg1NGglVuqQCc0QPoMGoHWk=;
        b=RyT5XkU2MT5Eugt5FnHAH9SFJ1nEbgxP07MV10azK0YmMFxaYIi8eHF28dG0vXOa6s
         nsWVnJkvMEgzWzC7M2Gr6bDWWYgMqLVieiazA1epZymaKwvotGMw2vncZIHYke0FaThE
         eA/OIyrUBTlQu6ncinxxFSa5liHnX1+n4wGzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561477; x=1698166277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzS/0bu5CDxLhlB0/9StVg1NGglVuqQCc0QPoMGoHWk=;
        b=DxBATvHQCCnu4BH3EgOMwmmVh5HX4OyzFOTNTceVSvLoa8KRhKHbeRFLKhHwXQZk5h
         fqW27SG4DKK3UgviJjfbvy/aI89MeZznpAxhcTNnFUwCIXkV+MdtwegTC1O2CzlfD55E
         W/D0nnyO8khXs/eXJT+GnBwWNRdbobtcM8mukeFZGyvRjkjxTzh35exSYEpZiyra8JAL
         hLVMw9ZgnQ722V0TT337HmszrvfThT8kNYatj+56CHUXtOV8aCXA2fuGfeYRK9QjWMC2
         zzddjpXObpjnrK/T/OWkxJaloaCJ8WTqiUlqrTSN/BXPoiBkEA17ACzp55cpxx7lMsEH
         N4sg==
X-Gm-Message-State: AOJu0YzkK7McVlojw/pa6ZxFT/D3uP9Wp089GABKzd8313PVxuIar45n
        aIWgl2y2hIE3mryJlQusxwkS0lgwBiTq5alBua0=
X-Google-Smtp-Source: AGHT+IG/ZlyDzPQMLSLOKVu56iVEMLSMUwAXiBl4Qd38zOqwcq9Ikqz6wCEaMsOu85/eYKBesV/FHQ==
X-Received: by 2002:a05:6830:33d3:b0:6c4:cda6:ff31 with SMTP id q19-20020a05683033d300b006c4cda6ff31mr2789647ott.15.1697561476765;
        Tue, 17 Oct 2023 09:51:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00000a00b006926d199fdcsm1686222pfk.190.2023.10.17.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:51:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH] perf/benchmark: fix seccom_unotify benchmark for 32-bit
Date:   Tue, 17 Oct 2023 09:51:10 -0700
Message-Id: <169756146776.2941832.18031040054074292190.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017083019.31733-1-jirislaby@kernel.org>
References: <20231017083019.31733-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 10:30:19 +0200, Jiri Slaby (SUSE) wrote:
> Commit 7d5cb68af638 (perf/benchmark: add a new benchmark for
> seccom_unotify) added a reference to __NR_seccomp into perf. This is
> fine as it added also a definition of __NR_seccomp for 64-bit. But it
> failed to do so for 32-bit as instead of ifndef, ifdef was used.
> 
> Fix this typo (so fix the build of perf on 32-bit).
> 
> [...]

Applied to for-linus/seccomp, thanks!

[1/1] perf/benchmark: fix seccom_unotify benchmark for 32-bit
      https://git.kernel.org/kees/c/65159865e69e

Take care,

-- 
Kees Cook

