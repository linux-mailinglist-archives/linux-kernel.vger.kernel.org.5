Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251B57EB407
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjKNPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjKNPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:46:52 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909AEBB;
        Tue, 14 Nov 2023 07:46:49 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-677a0ac3797so21975176d6.1;
        Tue, 14 Nov 2023 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976808; x=1700581608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW9wBDyWoRbGwVU/PloT5Dc64rb+TukhhYbMYHHOQuI=;
        b=eF4WlJ2JfpVEhzQJ4sJT/cV+I5iyqOM/k+xNZH6ucXrT4xFZRGZoRVOQo4kXScdlIj
         uKB925WkiwrkuZlNbeHfFYdF4+LV42taFpN25YbAxtvQIbOT7ut7e4Zxd2ZFnjSfvjfx
         mTabClR2FnVxHrbW8N48qeQBXHeDbVfkmN7tEZFmIRmX3hPIJmICfj2h+Cuy143VrAjw
         3+GSmbghyMkbJysiJVKYBWQPY/1ykg+WRjie37z7Zaze0mrsyZRZXBB/t7aTIYpXJQoP
         dqnfWOi60dD2zXgHmRwATtJs9c8sGUN8j3QYcyculpXTddqMsBvp9BglOkbro0wPfKEv
         gySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976808; x=1700581608;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TW9wBDyWoRbGwVU/PloT5Dc64rb+TukhhYbMYHHOQuI=;
        b=vXHAQzn+sn8OrG4FEDVUefRVGZ7D2xcl3RYADe2t1Xb7fZJk/MoT9wDPQ/3b4aP+BO
         mTusskB794xfUpXiZYiltLTr1jy9lnOJ+CiRvX2Ouw/7+pEu8UqWzmbDJqobSi4/01b2
         prmFff1uUwmalEFUcQ/y/JH3C5DQrHke5wEYl8+pcNfdJA9wDjwWpqRoCzHqiSMLUeXK
         KvovajX3Q5zRxSqrKwi5QnQdH59W9al79+EbtY2YSWvrZNsvw0yOVkAMALI7ceBICoWL
         Tmb1Utwr7+g070Xn1lfSmCPL3pgmeIbZK1YH9QNZ9wRV5fLa1uVIJJxBdQCcQTatjClE
         oP7g==
X-Gm-Message-State: AOJu0YwuFNadFFh5+iLHhYGUOy5hmmBlAgrpH2bXmjFM+T1LLVrw3+gL
        EbRFjYBopwGlmCpNd9FhLjU=
X-Google-Smtp-Source: AGHT+IFKbf8FR4PFFuO7HqTTBYa6xqAKgw/C37wRYaXRX+PCkQKWkH7a1FiLqgRkJ6vkJ7NOPCaWRg==
X-Received: by 2002:a0c:fd86:0:b0:672:22d:270d with SMTP id p6-20020a0cfd86000000b00672022d270dmr2592636qvr.30.1699976808712;
        Tue, 14 Nov 2023 07:46:48 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id z13-20020a0cd78d000000b0066d04196c3dsm3017341qvi.49.2023.11.14.07.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:46:48 -0800 (PST)
Date:   Tue, 14 Nov 2023 10:46:48 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Lucas Karpinski <lkarpins@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Message-ID: <6553966832afc_125ffe294b5@willemb.c.googlers.com.notmuch>
In-Reply-To: <jvzrm33xjrhal3qro37tfpfw2w4jbh35byjlogcc776xt4fpzy@zkmfoqn5ipil>
References: <jvzrm33xjrhal3qro37tfpfw2w4jbh35byjlogcc776xt4fpzy@zkmfoqn5ipil>
Subject: Re: [PATCH net-next v3] selftests/net: synchronize udpgro tests' tx
 and rx connection
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lucas Karpinski wrote:
> The sockets used by udpgso_bench_tx aren't always ready when
> udpgso_bench_tx transmits packets. This issue is more prevalent in -rt
> kernels, but can occur in both. Replace the hacky sleep calls with a
> function that checks whether the ports in the namespace are ready for
> use.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
