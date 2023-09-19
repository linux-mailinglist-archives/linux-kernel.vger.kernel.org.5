Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5557A6C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjISVCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjISVCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:02:13 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49257BD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:02:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-773eee0152cso23631685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695157323; x=1695762123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lVX+Hnhh2l6DmLPA8VTV6OqmMl0pnzem5EJJPR6Mhqs=;
        b=bjgN6kTVbTyiSjyJBPPu89Bejkh2gD21aeI3uyn+ekwqLMsBQxHQaKgi37zXykNQEb
         eLLOAA8Odxj18VxWxK4ytL095X0r5OUniYBAhQj6ngi7xe+sIJKahkmGuIaMWmVOxe3/
         xZirQQkniNSHcEuiZpN8Y5yL4GcjLAnZoqkeJtKzK+tAUnIVuvGgMpze/ZRRr8pPGCxK
         7wVLGUW/8Enh2pOoWAm5ENjeW2E9w2msRti8YaUIj630hT6bLCt9lnjZYu+dAV7DqYXs
         hdjz1RVnBHPLgtZ3ONL+649Jll+rMuy1nASGugjh+BwWCp9NjIoiFkXEeW7RrlUCmV99
         or9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695157323; x=1695762123;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVX+Hnhh2l6DmLPA8VTV6OqmMl0pnzem5EJJPR6Mhqs=;
        b=DlIxqAVbNeuaov8xV774zewvabyBHZVR/9WrB7y/pZdtZEIYBk/NlQZb+XthQ4Cgeo
         L9oDRhPJhu6hxrlzRm3z8HcP9VjuY6EAvkGGmcPZDanXMJrPdbPxqqAqqmBnFn1dcGiv
         zL0F4Mq8o2CXvBImN3sP7B68yH4bsMW6AhJFGYG/TJBxnUPxTeoJj2Iw9lSzu7m4ITbV
         83FDqYHIVsKEEht1RSuoNekiQiy/UIvgver/4HK5LIItO9uPNFQr7oM+4RIubrHt5cka
         l3Wa/zNPmlnV36GagNfZmQtkFsre+e61AVw0eXd8e7YnlzH9BnLiZcYFTd/VKF+bcr7M
         oscg==
X-Gm-Message-State: AOJu0YyC9g+sQfZsB1qvZn+/M6iMNA+kDIfDQfu3R1ZyupXG7WnZeS3d
        0bEoUUGSVw49rHAmWCpkjvv+tHSfCZozRFH14EzgXl5MuYNpmiDX4/3DlQ==
X-Google-Smtp-Source: AGHT+IEF2ThYM/mz7S/1qqdc26uccov5d1h2ccEPnZjX3XDy4DhRHHjf40u/n7W6FxrxUjiYIrdncY7If4XUxU9Syjs=
X-Received: by 2002:a0c:b2ce:0:b0:656:5176:c53e with SMTP id
 d14-20020a0cb2ce000000b006565176c53emr737526qvf.6.1695157323272; Tue, 19 Sep
 2023 14:02:03 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Sep 2023 14:01:48 -0700
Message-ID: <CAKwvOdkShCL8MAE+rJzSeAf54=UeHRnuWkHkfMKDeC4A0KoEEg@mail.gmail.com>
Subject: -Wuninitialized in drivers/accel/habanalabs/common/memory.c
 introduced by aa7b6367186e
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit aa7b6367186e ("accel/habanalabs: tiny refactor of hl_map_dmabuf()")

introduced a warning that's breaking the build in linux-next.

drivers/accel/habanalabs/common/memory.c:1735:11: error: variable
'hdev' is uninitialized when used here [-Werror,-Wuninitialized]
317 1735 | dev_dbg(hdev->dev, "Failed to map dmabuf because p2p is disabled\n");
318 | ^~~~
319/builds/linux/include/linux/dev_printk.h:155:18: note: expanded
from macro 'dev_dbg'
320 155 | dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
321 | ^~~
322/builds/linux/include/linux/dynamic_debug.h:274:7: note: expanded
from macro 'dynamic_dev_dbg'
323 274 | dev, fmt, ##__VA_ARGS__)
324 | ^~~
325/builds/linux/include/linux/dynamic_debug.h:250:59: note: expanded
from macro '_dynamic_func_call'
326 250 | _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
327 | ^~~~~~~~~~~
328/builds/linux/include/linux/dynamic_debug.h:248:65: note: expanded
from macro '_dynamic_func_call_cls'
329 248 | __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func,
##__VA_ARGS__)
330 | ^~~~~~~~~~~
331/builds/linux/include/linux/dynamic_debug.h:224:15: note: expanded
from macro '__dynamic_func_call_cls'
332 224 | func(&id, ##__VA_ARGS__); \
333 | ^~~~~~~~~~~
334/builds/linux/drivers/accel/habanalabs/common/memory.c:1731:24:
note: initialize the variable 'hdev' to silence this warning
335 1731 | struct hl_device *hdev;
336 | ^
337 | = NULL


Please fix. Also, please post your patches to LKML so people can post
info like this in response directly to your patch.  I could not find
aa7b6367186e on lore.
--
Thanks,
~Nick Desaulniers
