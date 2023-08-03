Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEF76EB34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjHCNve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHCNv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:51:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C9DF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:51:25 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5844bb9923eso11336607b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691070684; x=1691675484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TfS+q+g/wvbotFwtzxMOMoDCbRna0bH1a78XXprxeI=;
        b=EAJJVN1o5YA+3KBVdv4UscJmef4SKNv9Dbf+06cCaxesk/XtnA/l/PWHODeRspsWcc
         YdGZR6MkadCChnUKol6Iw/0jhT2x3TI/LXZ3fUAL4rKkTf+obRlsY7y1mBfmx3LwBW2m
         eN2JdaJoEfW7wbNvjKoyiqi3V7RHuyIPYYCM5E+qvaXHCyY0+hycn1P82kamT6ZxjBmu
         dMQ6fsn+WBeH2taUx+UAO7yGepL9nPRum6IXA/mY6UWv2BwCFWyEgL/fIppvGLISZETk
         WyJhjuyGn11ImF4entiMiPSWLkYEAB8CXCw3WmhV40vM+onvXTs961dLu62UslkN9fCg
         msMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070684; x=1691675484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TfS+q+g/wvbotFwtzxMOMoDCbRna0bH1a78XXprxeI=;
        b=GgbcE8jAJIjK+F7w9+uvg7B7PaHLXuUSoSvW0wttQT3pIKRNDF1S1MVEfIcD7jSB16
         /TP3AjMWYibjspE/cM1Oq8he1Otx9nPQPnLnuVL47evOl/8nYcSPxXOH0f4IIEy4tOjE
         fx8x5mGd97RkHu8/dUlm6goDZ6ETR4ij5fITx+J2Obim7lWiWu7P2Zog5NZioRTRuqop
         2GBx4t6ncrro2l2jwVAYG/AzjSSubn9blBOC9bZ4m2Hnm5YFpoM9onRIwTKFYXqXIG/n
         USdH/bcunDm9RrfCDg1Ewttf2cmHqqNn+V25qtJ77xFwgm0pjk8M13qGvFKIgZhuwLT9
         /TSA==
X-Gm-Message-State: ABy/qLZGPR90V//UkkI57uiu0wGdmp5c2CxyFd63xs+KHtHWzU36QFJM
        NvLPzVX33sAu7XCI2Z9+G71zlcLfQUf1cibBpwJLgQ==
X-Google-Smtp-Source: APBJJlFAN4u5b0arzVMb6FTR1fLhQVm1kNxh4BMhFDtGt59+JBJfXfFbXE8Qxy63E1Xh51gWowaVjw==
X-Received: by 2002:a0d:d6c8:0:b0:561:cb45:d7de with SMTP id y191-20020a0dd6c8000000b00561cb45d7demr20645639ywd.31.1691070684548;
        Thu, 03 Aug 2023 06:51:24 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id s9-20020a817709000000b005869e1d8c41sm144956ywc.29.2023.08.03.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:51:23 -0700 (PDT)
Date:   Thu, 3 Aug 2023 15:51:21 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
Message-ID: <ZMuw2SuGZtVX42Nu@nanopsycho>
References: <20230803082513.6523-1-justinlai0215@realtek.com>
 <ZMtr+WbURFaynK15@nanopsycho>
 <14e094a861204bf0a744848cb30db635@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e094a861204bf0a744848cb30db635@realtek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Aug 03, 2023 at 03:20:46PM CEST, justinlai0215@realtek.com wrote:
>Hi, Jiri Pirko
>
>Our device is multi-function, one of which is netdev and the other is character device. For character devices, we have some custom functions that must use copy_from_user or copy_to_user to pass data.

1. Don't top post
2. That's nice you have it, but it is totally unacceptable. That's my
   point. This is not about wrapping your out-of-tree driver and sending
   it as is. You have to make sure you comply with the upstream code.
   Which you don't, not even remotelly.


>
>-----Original Message-----
>From: Jiri Pirko <jiri@resnulli.us> 
>Sent: Thursday, August 3, 2023 4:57 PM
>To: Justin Lai <justinlai0215@realtek.com>
>Cc: kuba@kernel.org; davem@davemloft.net; edumazet@google.com; pabeni@redhat.com; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
>Subject: Re: [PATCH] net/ethernet/realtek: Add Realtek automotive PCIe driver
>
>
>External mail.
>
>
>
>Thu, Aug 03, 2023 at 10:25:13AM CEST, justinlai0215@realtek.com wrote:
>>This patch is to add the ethernet device driver for the PCIe interface 
>>of Realtek Automotive Ethernet Switch, applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.
>>
>>Signed-off-by: justinlai0215 <justinlai0215@realtek.com>
>
>[...]
>
>
>>+
>>+static long rtase_swc_ioctl(struct file *p_file, unsigned int cmd, 
>>+unsigned long arg)
>
>There are *MANY* thing wrong in this patch spotted just during 5 minutes skimming over the code, but this definitelly tops all of them.
>I didn't see so obvious kernel bypass attempt for a long time. Ugh, you can't be serious :/
>
>I suggest to you take couple of rounds of consulting the patch with some skilled upstream developer internaly before you make another submission in order not not to waste time of reviewers.
>
>
>>+{
>>+      long rc = 0;
>>+      struct rtase_swc_cmd_t sw_cmd;
>>+
>>+      (void)p_file;
>>+
>>+      if (rtase_swc_device.init_flag == 1u) {
>>+              rc = -ENXIO;
>>+              goto out;
>>+      }
>>+
>>+      rc = (s64)(copy_from_user(&sw_cmd, (void *)arg, sizeof(struct 
>>+ rtase_swc_cmd_t)));
>>+
>>+      if (rc != 0) {
>>+              SWC_DRIVER_INFO("rtase_swc copy_from_user failed.");
>>+      } else {
>>+              switch (cmd) {
>>+              case SWC_CMD_REG_GET:
>>+                      rtase_swc_reg_get(&sw_cmd);
>>+                      rc = (s64)(copy_to_user((void *)arg, &sw_cmd,
>>+                                              sizeof(struct rtase_swc_cmd_t)));
>>+                      break;
>>+
>>+              case SWC_CMD_REG_SET:
>>+                      rtase_swc_reg_set(&sw_cmd);
>>+                      rc = (s64)(copy_to_user((void *)arg, &sw_cmd,
>>+                                              sizeof(struct rtase_swc_cmd_t)));
>>+                      break;
>>+
>>+              default:
>>+                      rc = -ENOTTY;
>>+                      break;
>>+              }
>>+      }
>>+
>>+out:
>>+      return rc;
>>+}
>
>[...]
>
>------Please consider the environment before printing this e-mail.
