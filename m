Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A313781B65
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjHTAIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHTAIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:08:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9B10554B;
        Sat, 19 Aug 2023 11:08:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a3e271491so27598b3a.0;
        Sat, 19 Aug 2023 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692468515; x=1693073315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV81kcD9vzqzEmQhBftWFfOiwm9XqB0HTp7lUGKFHuQ=;
        b=C7qYTo1LyPFHC2dm+MmwF+hLNzvcmrZB2LBFsnfNl1z0tB0EgpgsWyN3xsA2TJHxV2
         iIsZr7PvOShCd4TbXPkvfAPkRZ0XWp+JrNo5O07S5xk95uw+vQK9PMCVopfoztX6hX/G
         RYtUfseiGEDIWpMAmgxkvAx9ESZCq+t/sNbF3YEQPjBA6IGdJEJKq6LOQfpsI2lVxv5L
         X25Fa/6NlHP9i5M/3MUiRiW8Oj+JDL22S3cfRyz6G3S/FyWnK+pp8WyCO3IKTDsyfxkx
         FtwFt4bYyQDv3apQyaJJHRIt+cM6/fK0AoXmay7m3uqFsdn7SFdmg/vK5Ry4uo9uhrX2
         K+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692468515; x=1693073315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV81kcD9vzqzEmQhBftWFfOiwm9XqB0HTp7lUGKFHuQ=;
        b=CJ6VK5Wb9/XrK+lMpokHqwpqqRJeuoIz6p+M9bMH7KHIgHb+tVVY5mgNZhcCIXayRU
         KHQxIk2WGMbk3e1rhPvTYpybpRILLhm+yZfboTkKG6uA5aCdimetbYpiPyWMnV/r83hg
         XzNyXqxFs2/HKTHiZVSCKNb2WZEJZW9Ufkp4Rb1y4M+WOlmzdcGIqe86USKMf4a1j2X+
         6EuQbVdkopzjLY8NLH0B1AOq8AvVudy2FnP25O7OKHqUkqp7Hh99uX8AX015t4JQwHFi
         qG9seP7WjMfQCB4NzxeW9Gi6lYY9uApOqIliAA6T4TfGVT6A+w1veeYuHO1T4wzJe6og
         g+fQ==
X-Gm-Message-State: AOJu0YxIfGeXCQCQSfHsc1Pdr0Kpf0/aW0J1HijZ/rL+Ji7AXLYnXkVx
        UbC4EryKpYVaU7PSqksEDk0=
X-Google-Smtp-Source: AGHT+IF7EedqvwbI3ba5+mmLhdYeO7tD4JUyYmKEOPCFp8pBzMa7oyrnaLm3L04xO1eVykt07TWdOA==
X-Received: by 2002:a05:6a20:1447:b0:148:40cf:b832 with SMTP id a7-20020a056a20144700b0014840cfb832mr2009601pzi.18.1692468515010;
        Sat, 19 Aug 2023 11:08:35 -0700 (PDT)
Received: from DESKTOP-7B1REV8.localdomain ([2001:569:5755:c600:f49d:4018:e752:1f22])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001b8b07bc600sm3890891plg.186.2023.08.19.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 11:08:34 -0700 (PDT)
From:   Qingjie Xing <xqjcool@gmail.com>
To:     edumazet@google.com
Cc:     davem@davemloft.net, dhowells@redhat.com, fw@strlen.de,
        johannes@sipsolutions.net, keescook@chromium.org, kuba@kernel.org,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
        xqjcool@gmail.com
Subject: Re: [PATCH] netlink: Fix the netlink socket malfunction due to concurrency
Date:   Sat, 19 Aug 2023 11:04:48 -0700
Message-Id: <20230819180448.2315-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
References: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This piece of code has been present since the Linux code v2.6.12 was
incorporated into Git management.
I believe this modification could potentially address the concurrent issue
we've been discussing.
In netlink_rcv_wake(), as described in [2], the socket's receive queue is
empty, indicated by sk_rmem_alloc being 0. At this point, concurrent
netlink_attachskb() calls netlink_overrun(). In this critical state, the
sk_rmem_alloc of the socket will not instantly transition from 0 to a
value greater than sk_rcvbuf.
