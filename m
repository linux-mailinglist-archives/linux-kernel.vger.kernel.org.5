Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1970A775CB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjHILaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjHILaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:30:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875F010DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:30:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-317b31203c7so5760479f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691580601; x=1692185401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBceCfVub0Uw5B1q4o8BqQH40Gf5UUlogeBvGLCs9CI=;
        b=Jp0HDERCDp6Y7stD/+Wp+4h/t4pnKdXZkT+bbeVlfbc+53JEeT4k+tlrWiOcr107/w
         LLBldfh43PJT24sxxe59hatSkhx63DidnDIzYE0d7b4N+5PIS7NMpX4uyI1B8ffSbMuV
         fpg9ucX1voAEEueFwsgY24ifl0fuebX4sX80xrIqxR6jCNmm+drDl/uKGhlN5H1Y6MQz
         wRqo9IJ4fM0e6J3QQogjo/mkMF2pEjmCGXF/C2XBRV2s+1Lf2/SmT2RQ1jf4XZVmD6Au
         3ObSHHXyFmY1Qr1irIxK+MsE+2RKTtSGrV/ALsF7NcuzFlJqC/uOCJWxhw8OKVhrRoKO
         VH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691580601; x=1692185401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBceCfVub0Uw5B1q4o8BqQH40Gf5UUlogeBvGLCs9CI=;
        b=kKTB+wb3L9UXif4V6ZYi+U7nFU+EXi0mlQB5YPB51zdhk7GpU/6yLM7gMR+7kBoelG
         p6xs8np/3Sj0ASZdfrUd4WVRh5SJk5uLyaDp7jafBQrrW3IQJi+2+KTMsF9/K+tODhAi
         Ngf0J/d6KCKYsmknQ5h/w1fwhVsnyOpJKrhrip2tlh+aeqJ3hz1BWO/8C6uQDZxXp4T2
         r35o55q57PYY4+8y5JyA5ymks3glYzYZxSKEKhIozfXdkCewBsY/DHbZ7Aw+3+SUGMXJ
         tAfz7g87amhrUraJPUlNprYo5owdCs2bEK7mH8vQ4msmZGo/RUla9qb8joNRWF314aNW
         s1uA==
X-Gm-Message-State: AOJu0YxdltpOrMrV9YTa0cOd/bu8V8Eokhf4yleoaDKKN+nAVNqTpvpD
        UQxBQkJ6UnIsee9LbOaAYeI=
X-Google-Smtp-Source: AGHT+IGNPr4Z9DZZAoaGnQzPNQfwyQm2wCYHvJF1i7mW0tIAj2rOF1Jx7++Gjp7KSdYLVA4awIg2qA==
X-Received: by 2002:a5d:4d0c:0:b0:317:51da:83b9 with SMTP id z12-20020a5d4d0c000000b0031751da83b9mr1454840wrt.49.1691580600814;
        Wed, 09 Aug 2023 04:30:00 -0700 (PDT)
Received: from archdev (pa5-84-91-151-142.netvisao.pt. [84.91.151.142])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d5246000000b00317f70240afsm5456092wrc.27.2023.08.09.04.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:30:00 -0700 (PDT)
Received: by archdev (Postfix, from userid 0)
        id D0BAC1A3960; Wed,  9 Aug 2023 00:25:13 +0100 (WEST)
From:   Diogo Silva <diogompaissilva@gmail.com>
To:     dan.carpenter@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        diogompaissilva@gmail.com
Subject: Re: [PATCH] staging: wlan-ng: cfg80211.c: removed unnecessary parenthesis to match coding style
Date:   Wed,  9 Aug 2023 00:24:48 +0100
Message-ID: <20230808232456.3402-1-diogompaissilva@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <dan.carpenter@linaro.org>
References: <dan.carpenter@linaro.org>
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

Hi Dan,

Thanks for the help. I did not realize it was a re-submit. I tried to look for anything similiar but since I did not find (my fault) I thought the bot had assumed it was a re-submit because of the empty message body. I will try to find something else to work on!

Also, thanks for the resources (lore.kernel.org and the v2 patch instructions).

Best regards,
Diogo Silva
 
