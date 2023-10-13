Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47837C87AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjJMORQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjJMORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:17:15 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF8BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:17:13 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79fb8f60374so25207839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697206632; x=1697811432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lb0SFgyj6zGJaRNFKO8Je487qWXLpWh8PHdGLC7mEg=;
        b=rU54gqVEzYsQZ7f6VJPxHh7iNpzjdOpdnTAa21/nEuGR1zJtX4M54Vglev3lFy5vDf
         ztz090y0fkMw6xq2hqfo1fVIocvrAe3ki7TNWk69hbFr/z070KePQqPuqSwdTpqIhArk
         3PL0FLtDrWufqMa1Yf7HKmdWaHZpHmvp0aQXi0INB+sNQrBnLvU98l88Swd9m3brAldk
         +VqgY/L7DjiLiwGpkAlg9XltcTFw6xU671ZXmTZHfR38wqQUOsY+A9x8ZBYEtKIFkMhc
         ZPrmwOFy3tHz9tUiUrCHdIggH9TtlsXj4MPD+mXznBGkAXtEGD974jjoYE0v6VW4tLrM
         lNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206632; x=1697811432;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lb0SFgyj6zGJaRNFKO8Je487qWXLpWh8PHdGLC7mEg=;
        b=GNQHYrN0FV1kMpZYRKDf6l5GGshhEkyGOC9K/80Awbz0MVTLXNX5c/ROhPX9bPaVhL
         a/cT01MbCTiuMj13OI/1LSlD7QKBk0U/RPEs6doKgGE36EpTWxX74692mUjCSnXQTwAr
         sJ1ntyqFY4EV7O99gew9fLz//O6XpTA3ODA/SomPA0GXxXk4X3GFkWlx3ByNvZOFMiBO
         0CkveWFVsnka6FOky24Eg9492FH3I9meh9v8JQCAPVFRPpMAh/r5HMWcnn9uYY4vvRIP
         ysu32EsuFDbKm2YD0zmDMgCAU+64TAJyl06IKPDRbo0BktsJtTOnJlNvDBwk36+b7XFj
         jyiA==
X-Gm-Message-State: AOJu0YzBuaPC0UZMTWmyD5IshIDLZ5z+9sjH/I6P2G6mF/NVfrRbdwmv
        JIsC+bbUfJTQFnfKMThjTFd9sw==
X-Google-Smtp-Source: AGHT+IEydHkg/2e8895o6lSJMDIQXRgt9993c9M2+hVQE0mcpprgcN8ai280jQg9eHXky6Ub5tyYkw==
X-Received: by 2002:a05:6602:2a44:b0:792:9b50:3c3d with SMTP id k4-20020a0566022a4400b007929b503c3dmr33052533iov.1.1697206632640;
        Fri, 13 Oct 2023 07:17:12 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r29-20020a056638045d00b0043a1b134b10sm4479225jap.114.2023.10.13.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:17:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
Cc:     gjoyce@linux.vnet.ibm.com, jonathan.derrick@linux.dev,
        linux-kernel@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
In-Reply-To: <20231003100209.380037-1-gmazyland@gmail.com>
References: <20231003100209.380037-1-gmazyland@gmail.com>
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
Message-Id: <169720663183.1920390.9547818439734957498.b4-ty@kernel.dk>
Date:   Fri, 13 Oct 2023 08:17:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Oct 2023 12:02:09 +0200, Milan Broz wrote:
> The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
> introduced the use of keyring for sed-opal.
> 
> Unfortunately, there is also a possibility to save
> the Opal key used in opal_lock_unlock().
> 
> This patch switches the order of operation, so the cached
> key is used instead of failure for opal_get_key.
> 
> [...]

Applied, thanks!

[1/1] block: Fix regression in sed-opal for a saved key.
      commit: 4eaf0932c69bdc56d2c2af30404f9c918b1f6295

Best regards,
-- 
Jens Axboe



