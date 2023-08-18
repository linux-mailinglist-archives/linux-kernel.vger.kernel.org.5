Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC77805D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357958AbjHRGFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357717AbjHRGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:04:36 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BE30E9;
        Thu, 17 Aug 2023 23:04:34 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso64910666b.1;
        Thu, 17 Aug 2023 23:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692338673; x=1692943473;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2pHGRjubj9loM4rlnSBB8B0NBJEkF4e8IGQOJotz1E=;
        b=E49aNMoyhSGprnWWvLncKuA3lsjC0FoDWBxAVtUWUWIhHKFV1hjHqKPmr46nkZu5lx
         LUM6BfK3xUhdeUygbQK13fJSx8VcntzzfyCykwsCcG4JPS6nvy+zIZaEgCsbgIfop4zy
         TB0PbkvqUS9iY1ATZVmHAe7uSR49mWmKG7j+jfTAjewVH6L6UU2miHg1stnqPA9oAv0J
         mdzlCSmA4XTRK12kc6WSgYnETiNHftFEMetgcal9FHYa0eBo159wzr5kZqKdbZuPdvIu
         ptNvfEc78NDhZuBhi450X2XhDyl/pxW9Kriy3ZWlO+VzxGCWYj94lj7kkQaciJbh/2Tl
         WGGw==
X-Gm-Message-State: AOJu0Ywo73eFHXI8fMjiPBbje8a6EhcVR9gDJCPFDDfV15US9muJ3AIM
        zeQqQy/eNdzDs85GJy9Y3gs=
X-Google-Smtp-Source: AGHT+IFyDqYKYpdUEqIE4zH8QDMlDuxP5lTa6oRNWYNxSC75jtLr7Y/tZRARUOxviPWlVJLzTV7YIQ==
X-Received: by 2002:a17:906:3d32:b0:99e:f3b:2f7d with SMTP id l18-20020a1709063d3200b0099e0f3b2f7dmr1033218ejf.74.1692338672907;
        Thu, 17 Aug 2023 23:04:32 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709061c4300b009882e53a42csm754990ejg.81.2023.08.17.23.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 23:04:32 -0700 (PDT)
Message-ID: <d92e7938-49e0-3b4c-89ab-77dcd15b8676@kernel.org>
Date:   Fri, 18 Aug 2023 08:04:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817163708.GA8248@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] kill do_each_thread()
In-Reply-To: <20230817163708.GA8248@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 08. 23, 18:37, Oleg Nesterov wrote:
> Eric has pointed out that we still have 3 users of do_each_thread().
> Change them to use for_each_process_thread() and kill this helper.

Is there any change in behavior? Why is for_each_process_thread() better 
than do_each_thread()?

thanks,
-- 
js
suse labs

