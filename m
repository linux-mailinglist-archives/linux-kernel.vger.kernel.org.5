Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8447B4008
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjI3KmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjI3KmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:42:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E9C2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:42:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso12271799a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1696070523; x=1696675323; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=DvRzfQhQ7LuGv2SDRu07O7Peq9O6AwK5ElRvmdjHDy4=;
        b=Xz0dx2QwmFppbiRpOQU0M6odD1pjOIb0F70bJVU5PYDvGp5WYCbYMcn1JmWacE+WGK
         eMwpx7tqvMjNy5RUQ6KNcElWN/QL6IpFyZTsf2jxgfDEc5U4MyqfH1hSxqHbkkariz8P
         3hcQ6KU8XEQLlZzDdKYaZ9GuQVkqTMoFBjpkQRb9ajvOMvzA4W3Z49HXewmsLR0SitrN
         LULmN2iZbr6wKH9xnT1OOodzDvhNg7AqmZ+/TYLjtRzCqpmQxseo/dAio0ZKGczKkIi8
         GUeI0LSkgPRPzi3LfMBVm3OyIvIYev506dArBYE7unglODA6kfpCjVgVRz4/HO7Phdun
         OuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696070523; x=1696675323;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvRzfQhQ7LuGv2SDRu07O7Peq9O6AwK5ElRvmdjHDy4=;
        b=afpzxeicSVIkU1NEyu+8x7OXjG3uapiy5WUCQHB8QH3N3wdkcyah5z5u/Xi+4bwccy
         WM12qINgPHUy2+vZjam1zEJ2WbhHFxqoYyfE3yHQdvNsy1dvVeMg+3q1D8CcPP2fLAU6
         uDS5L1nSSt5r87+6Elmh2tu2g0Yh59XN6O0N1dZLfvhp3Gv1vvJZ4A/RHUQwzaygjUX9
         EgbS8k98j1JMVYZG4HfRbifSQk0/k9/OXhw7nIiGPcLED5l0lxAp2jjRK9JoEe1X43gJ
         pZWkWhhNiy3q7KmVY8koloXiGDt3lO07YkKy+M093ITZtZcSWZ2EX15h8fjk8Kg6SS9S
         lgiQ==
X-Gm-Message-State: AOJu0YwZ+Lx9QCbwqeHmii2k5TiHm1vr3X758pYnyje+X+EsznFLPjxr
        JvsyCq44ST6COAYpB5Kr0agX+w==
X-Google-Smtp-Source: AGHT+IGxJBVh05PsVUK1L7srvncGtUALhlM9L9Vvqy5gRtXT5ZyLY1wSpWb1ax6M/ENp8cF5itM1pg==
X-Received: by 2002:a17:907:7632:b0:9b2:cf77:a105 with SMTP id jy18-20020a170907763200b009b2cf77a105mr4337138ejc.15.1696070523611;
        Sat, 30 Sep 2023 03:42:03 -0700 (PDT)
Received: from cloudflare.com (79.184.153.47.ipv4.supernova.orange.pl. [79.184.153.47])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906140700b009829d2e892csm14160474ejc.15.2023.09.30.03.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:42:03 -0700 (PDT)
References: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 0/2] Support multiple interrupts for virtio over MMIO
 devices
Date:   Sat, 30 Sep 2023 12:40:41 +0200
In-reply-to: <20230929-jakub-os-90-trim-v1-0-a3af0c08f812@cloudflare.com>
Message-ID: <87o7hkc58m.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject prefix should have been [RFC]. My mistake.
