Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0897A1FED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjIONkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjIONkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0C2810D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694785150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QWQ6HpryQ0bML/qjw5uUsfLopCWdd/5evxlCWjifOSg=;
        b=gM6Dk6rWsU2TyhUEExItz1sMC/p881uheYKLMp043e1/iTxhe2zGAcil5nWQ1e4Cy6UXy0
        PGjlYAGPTRV/n/NBz9BnvZyzhDD53RFYXH8/b9gXdKzj4NjDbOZkLqP/GH4wii4Q2hx0S8
        wplLloJrU1p6OFCbxeBaWDPA3CliRQw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-QKcwhkZnMzO22uXId02z2g-1; Fri, 15 Sep 2023 09:39:09 -0400
X-MC-Unique: QKcwhkZnMzO22uXId02z2g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4121e93c0deso21893861cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694785148; x=1695389948;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QWQ6HpryQ0bML/qjw5uUsfLopCWdd/5evxlCWjifOSg=;
        b=iv8yDb8PlLpPdooGd85hDcAMM095cuYrGMRRg42jTkMy/hUdn/38P/iOoEC6MKmeVE
         A26T2gtIsnppQHWchO6sI/+OD5MNpVVhpo7x6zgJs0zf9/bvZDJPftW3UNgQ9SwkQKlc
         7yS1BrM212UQYGZZYqLIBJxjrDSUdpDpY3a9Ccn5f+iT7xsY+p7b2WxTfNo0h2VHkvJW
         5J4KAOz41P+54w2gcCurar2LwDJsYLeYjFH2W2NQIDJMDA14lFe7UBd7nUGMVQFsDGV4
         IwR0MDEbTNkKLsWu4tFHFGaNNWXj/A8QbOmjFSSDRQu6RofKegyRrn1kwRwDNeJycFkF
         NkNg==
X-Gm-Message-State: AOJu0YzRHNY/pjcuhTTAKMzRwp+yfsueh/Y3e0kfHGoofDlZc2WrUcMF
        QpAcr1R4TtqXmwPUjrJSPkrupuSzUk/1rjJgPGZfpMkB9D14JCk/WOX0Cuy7ecNR6NxrBcG5MtT
        svkZZEo9RbUbPIGouno2pC7zS
X-Received: by 2002:a05:622a:448a:b0:417:914a:104d with SMTP id kb10-20020a05622a448a00b00417914a104dmr1304510qtb.49.1694785147835;
        Fri, 15 Sep 2023 06:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF56shEJ2THKFDWi+zsrwOD4B7ezatOI4wP6uCMcWFXDWoImxIDrSVBHRjzjIdKGXuu7S5YQQ==
X-Received: by 2002:a05:622a:448a:b0:417:914a:104d with SMTP id kb10-20020a05622a448a00b00417914a104dmr1304499qtb.49.1694785147550;
        Fri, 15 Sep 2023 06:39:07 -0700 (PDT)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h5-20020ac87765000000b0041514d1da65sm1162548qtu.20.2023.09.15.06.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:39:06 -0700 (PDT)
Message-ID: <6100798b-ab1d-262a-fd5b-435d6dfc4a53@redhat.com>
Date:   Fri, 15 Sep 2023 09:39:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Dave Miller <davem@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, jschlst@samba.org,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Prarit Bhargava <prarit@redhat.com>
Subject: SPDX: Appletalk FW license in the kernel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey davem,

There has been a request in Fedora to confirm that the License field of 
all the RPMs is correct [1].  We've made some recent changes to the 
Fedora kernel [2] to correct the License field [3].  This License field 
reflects the license of the *source* code and does not reflect the 
license of the final binaries.

During our investigation we discovered two files in the kernel

	drivers/net/appletalk/cops_ffdrv.h
	drivers/net/appletalk/cops_ltdrv.h

which from their descriptions imply that the code contained is not GPL, 
and seem to be in conflict of the kernel's overall license GPLv2.

To be clear, I am not asking for their removal, however, I do think a 
better license should be issued for these files.  The files were 
trivially modified in 2006. It could be that the code in question is now 
unused and it is just easier to remove them.

Is there anyone you know of that we could approach to determine a proper 
SPDX License for these files?

P.

[1] https://docs.fedoraproject.org/en-US/legal/update-existing-packages/

[2] https://gitlab.com/cki-project/kernel-ark/-/merge_requests/2648

[3] License: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-2-Clause) 
AND ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) AND 
((GPL-2.0-only WITH Linux-syscall-note) OR CDDL-1.0) AND ((GPL-2.0-only 
WITH Linux-syscall-note) OR Linux-OpenIB) AND ((GPL-2.0-only WITH 
Linux-syscall-note) OR MIT) AND ((GPL-2.0-or-later WITH 
Linux-syscall-note) OR BSD-3-Clause) AND ((GPL-2.0-or-later WITH 
Linux-syscall-note) OR MIT) AND BSD-2-Clause AND BSD-3-Clause AND 
BSD-3-Clause-Clear AND GFDL-1.1-no-invariants-or-later AND 
GPL-1.0-or-later AND (GPL-1.0-or-later OR BSD-3-Clause) AND 
(GPL-1.0-or-later WITH Linux-syscall-note) AND GPL-2.0-only AND 
(GPL-2.0-only OR Apache-2.0) AND (GPL-2.0-only OR BSD-2-Clause) AND 
(GPL-2.0-only OR BSD-3-Clause) AND (GPL-2.0-only OR CDDL-1.0) AND 
(GPL-2.0-only OR GFDL-1.1-no-invariants-or-later) AND (GPL-2.0-only OR 
GFDL-1.2-no-invariants-only) AND (GPL-2.0-only WITH Linux-syscall-note) 
AND GPL-2.0-or-later AND (GPL-2.0-or-later OR BSD-2-Clause) AND 
(GPL-2.0-or-later OR BSD-3-Clause) AND (GPL-2.0-or-later OR CC-BY-4.0) 
AND (GPL-2.0-or-later WITH GCC-exception-2.0) AND (GPL-2.0-or-later WITH 
Linux-syscall-note) AND ISC AND LGPL-2.0-or-later AND (LGPL-2.0-or-later 
OR BSD-2-Clause) AND (LGPL-2.0-or-later WITH Linux-syscall-note) AND 
LGPL-2.1-only AND (LGPL-2.1-only OR BSD-2-Clause) AND (LGPL-2.1-only 
WITH Linux-syscall-note) AND LGPL-2.1-or-later AND (LGPL-2.1-or-later 
WITH Linux-syscall-note) AND (Linux-OpenIB OR GPL-2.0-only) AND 
(Linux-OpenIB OR GPL-2.0-only OR BSD-2-Clause) AND 
Linux-man-pages-copyleft AND MIT AND (MIT OR Apache-2.0) AND (MIT OR 
GPL-2.0-only) AND (MIT OR GPL-2.0-or-later) AND (MIT OR LGPL-2.1-only) 
AND (MPL-1.1 OR GPL-2.0-only) AND (X11 OR GPL-2.0-only) AND (X11 OR 
GPL-2.0-or-later) AND Zlib AND (copyleft-next-0.3.1 OR GPL-2.0-or-later)

