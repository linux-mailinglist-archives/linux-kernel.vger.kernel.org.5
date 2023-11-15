Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324C27ED855
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjKOXxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjKOXxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:53:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252A8E6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:53:01 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc921a4632so2383815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700092380; x=1700697180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNz1LZLWLqztNC1mkWelul3LmT7uMEIxjhxqq8dOWJk=;
        b=E3Am9kHrzGiKvuQ7Wd3p1RtKWgvVBsR+Hwym+gYpCIu1YzMG6e2EEDY7D97fEWMe09
         xieMnX9zRJuZ5cfKNmtKGSjJRQjVeDwjntPuBLtHAsxeucEELoD57FBXzD5QXgq02q+5
         FxdQ99Ik8qW7DtUz3WqOsHOOS0kOka5F+vBXD392JG+jYsC+FLMfZZylaH99OLbw4Odu
         L4TcFcqH/JF/GXMfaapgLL8e4+1C2y9dnXvc1G8+ydcIP6b2UXT5qfOYS48fy3RwUdRR
         8ue7LgHqswrHw+e9Kj8VPLFhxrWIOtj/tP6qFh+7jNFBKGHUN2p0wHUIHaN7oHqsj21H
         0hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700092380; x=1700697180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNz1LZLWLqztNC1mkWelul3LmT7uMEIxjhxqq8dOWJk=;
        b=Gz/3xxJ1zA7PaRbHRh7NqxO1SeVvQhqFr1bJcM+D41IjfX4MoBy+CVDogCRgLyc1kP
         5qMx8exkREl5fIuJZFOj0A8QrVrAvC+nxHfzxQ9TSzACwpJk9cLgsKPzaoUiwRHbIrH7
         B7kYOvf5tiy/07eKFc3HLAuKSoK0gOdmIX8sHx+ePpFua44IxcQDwwvhz8Q2bxXu+lnx
         NIU12gSBwYVL1S/jG15HrlOT3orzDXqtrCdQxpXR1Go8/Usf1NY75Zgof/ql3wwoll/z
         w5LbWubeTX4uPG8vE2wKgefpontDGL/18omY73BYX5RxlxkMPZ0Gb18U18VV3/NakHl3
         jVOw==
X-Gm-Message-State: AOJu0Yy3Pe/oJ89J0tDmAE0kOLZx/1lslRxUzWdmUoMeusCU4MdlnSoD
        7DBfIUsa5I7Oa2bS6jGKSZclyg==
X-Google-Smtp-Source: AGHT+IFXwoOe3aV75o7N/RNqxVPQxI4r3UiEus4sBc1W5lL/WagI4kLVy6eVv3qf/8n+XUliy6+PZg==
X-Received: by 2002:a17:903:2341:b0:1c7:5f03:8562 with SMTP id c1-20020a170903234100b001c75f038562mr9891201plh.30.1700092380545;
        Wed, 15 Nov 2023 15:53:00 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001c9ba6c7287sm7923702plb.143.2023.11.15.15.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 15:53:00 -0800 (PST)
Date:   Wed, 15 Nov 2023 15:52:58 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        kys@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH net,v4, 3/3] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231115155258.5b3f360b@hermes.local>
In-Reply-To: <1699627140-28003-4-git-send-email-haiyangz@microsoft.com>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
        <1699627140-28003-4-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 06:39:00 -0800
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> +static int netvsc_prepare_slave(struct net_device *vf_netdev)

It would be good to not introduce another instance of non-inclusive naming in network code.
Please think of a better term. Can't change IFF_SLAVE but the rest could change.
