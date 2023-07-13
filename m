Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33EC75187E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjGMGB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjGMGBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:01:50 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153CD1FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:01:49 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so2304255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689228107; x=1691820107;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9l+kGMflekFsEW8vlm5HTrA0Hh42ODE4b7HvnoBst8Y=;
        b=PNwyKS0G2QtZhcNyhCvJZR1334SEgEHt9PO380nAh09OUI3v+VIp6gRcgPMqrz2pkK
         pYUmma0eaNWuh3uNC2vpMql6kReFKtf/1LLYWB9sv7LO5NmJCm7zZDoB48nzdnbQhYIz
         a6u+hobi1lj4LZKbfDpiJwircLdSbZug/Lo13n+env7QvgqVj7XR1t+21FOuFEHUKg/M
         KbeE8Sib/ybWpsNr26jTSs8SZfZ6NHenONe2x3isNjy9UVxTpyad7W8cHWj/QNHnlCxi
         NTbm3pqO9ch7kRqmUxekGRA6jZqGJt8/bxKiqL+ohNSGrDqLaq1fvCje7JwqZBzQBD32
         JMjQ==
X-Gm-Message-State: ABy/qLb4cMAVAVySJt+vAclcfrZZmA+BXtixR0N9HV8Be2J10prx3d0k
        2r0qwgesWu018pTFieJNbe4=
X-Google-Smtp-Source: APBJJlFcWHq7EaJmNEH8qGvCK0UGloanuAgqe3f/XjU0hEx22fB8zuEs/LRqM7JTb0+f4106V+EO4w==
X-Received: by 2002:a05:6000:87:b0:314:449e:8536 with SMTP id m7-20020a056000008700b00314449e8536mr511159wrx.10.1689228107304;
        Wed, 12 Jul 2023 23:01:47 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id z22-20020a7bc7d6000000b003fbcdba1a63sm6770164wmk.12.2023.07.12.23.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 23:01:46 -0700 (PDT)
Message-ID: <a71ee5b3-2d17-e32f-45e1-0c351cdc501b@kernel.org>
Date:   Thu, 13 Jul 2023 08:01:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] TIOCSTI: always enable for CAP_SYS_ADMIN
Content-Language: en-US
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Dave@mielke.cc
References: <20230710002645.v565c7xq5iddruse@begin>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230710002645.v565c7xq5iddruse@begin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 07. 23, 2:26, Samuel Thibault wrote:
> 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") broke BRLTTY's
> ability to simulate keypresses on the console, thus effectively breaking
> braille keyboards of blind users.
> 
> This restores the TIOCSTI feature for CAP_SYS_ADMIN processes, which
> BRLTTY is, thus fixing braille keyboards without re-opening the security
> issue.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Acked-by: Kees Cook <keescook@chromium.org>
> Fixes: 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")
> Cc: stable@vger.kernel.org

Acked-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

