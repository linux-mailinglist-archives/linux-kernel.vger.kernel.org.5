Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F3C804485
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjLECQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjLECQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:16:26 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FEFA0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:16:31 -0800 (PST)
X-QQ-mid: bizesmtp73t1701742571t27qvrey
Received: from localhost.localdomain ( [219.147.26.62])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 05 Dec 2023 10:16:10 +0800 (CST)
X-QQ-SSF: 01200000000000B0J000000A0000000
X-QQ-FEAT: BrDpOp69VIgh1LmmdXWe5hrHwbYknXgT+5PK4U/K0/Zz0fGEzR5KRtl4jA2fW
        VMX5zZA4o8O/7oiZRokHJCAnKxURkkg414BSDsX8VgcYnVWLiDjS+PQ/ZO/bEa3zM4dLmPF
        qjTWbRa07+Ty/KaH3M8cCOodNi77BwRu8Mx5BOaOyMAE1sinxGLoRAv/3BkjJrjU3PwQjch
        tTKx62wx+expabBQCgf0Geaj8y5merMhXEW6DJ4YsCaYv/Cl2HozGRtJjCmvF/Qm0jYAOGI
        Vr/hLXzW9mxXD9S8Bar5uLbGIJu4Xx8D1j/LQlrwlCYNGauyjk69tEaYmm74x/MgmHrA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13659466830325708100
From:   Jialu Xu <xujialu@vimux.org>
To:     nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
        justinstitt@google.com
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: 
Date:   Tue,  5 Dec 2023 10:15:23 +0800
Message-Id: <20231205021523.4152128-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204165920.GA16980@dev-arch.thelio-3990X>
References: <20231204165920.GA16980@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:vimux.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Dec 04, 2023 at 06:41:42PM +0800, Jialu Xu wrote:
>> When symbolic links are involved in the path, os.path.abspath might not
>> resolve the symlinks and instead return the absolute path with the
>> symlinks intact.
>
>Can you provide an example or more detailed description of how this
>behavior is currently broken? I can't really understand how having
>symlinks in the path after normalization would break anything but I am
>potentially missing something :)

Glad to show my situation:

Say "drivers/hdf/" has some symlinks:

    # ls -l drivers/hdf/
    total 364
    drwxrwxr-x 2 ...   4096 ... evdev
    lrwxrwxrwx 1 ...     44 ... framework -> ../../../../../../drivers/hdf_core/framework
    -rw-rw-r-- 1 ... 359010 ... hdf_macro_test.h
    lrwxrwxrwx 1 ...     55 ... inner_api -> ../../../../../../drivers/hdf_core/interfaces/inner_api
    lrwxrwxrwx 1 ...     53 ... khdf -> ../../../../../../drivers/hdf_core/adapter/khdf/linux
    -rw-r--r-- 1 ...     74 ... Makefile
    drwxrwxr-x 3 ...   4096 ... wifi

One .cmd file records that:

    # head -1 ./framework/core/manager/src/.devmgr_service.o.cmd 
    cmd_drivers/hdf/khdf/manager/../../../../framework/core/manager/src/devmgr_service.o := ... \
    /path/to/out/drivers/hdf/khdf/manager/../../../../framework/core/manager/src/devmgr_service.c

os.path.abspath returns "/path/to/out/framework/core/manager/src/devmgr_service.c", not correct:

    # ./scripts/clang-tools/gen_compile_commands.py
    INFO: Could not add line from ./framework/core/manager/src/.devmgr_service.o.cmd: File \
        /path/to/out/framework/core/manager/src/devmgr_service.c not found

Use pathlib.Path resolve() instead, got the correct path

    # cat compile_commands.json
    ...
    {
      "command": ...
      "directory": ...
      "file": "/path/to/blabla/drivers/hdf_core/framework/core/manager/src/devmgr_service.c"
    },
    ...

>> -    # Use os.path.abspath() to normalize the path resolving '.' and '..' .
>> -    abs_path = os.path.abspath(os.path.join(root_directory, file_path))
>> +    # Make the path absolute, resolving all symlinks on the way and also normalizing it.
>> +    abs_path = str(Path(os.path.join(root_directory, file_path)).resolve())
>
>I think this can be more simply:
>
>    abs_path = str(Path(root_directory, file_path).resolve())
>
>I think there should be a comment around why we are creating a Path
>object then creating a string from it, rather than using the Path object
>directly, namely that PosixPath is not JSON serializable.

Nice, update as yours, thanks.

>>      if not os.path.exists(abs_path):
>>          raise ValueError('File %s not found' % abs_path)
>>      return {
>> -- 
>> 2.39.2
>>  

