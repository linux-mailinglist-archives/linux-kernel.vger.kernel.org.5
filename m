Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFA797E88
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjIGWCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbjIGWCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:02:19 -0400
Received: from cmx-torrgo001.bell.net (mta-tor-003.bell.net [209.71.212.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE6E1BC9;
        Thu,  7 Sep 2023 15:02:15 -0700 (PDT)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [142.198.135.111]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 64E88507015705AD
X-CM-Envelope: MS4xfMguLgi8rgOYYRlMsto9Ayq2NmgVNKUBCk79F5EH/AZzO9PbzVP60RGbo6lhY50wZggkSlued0wG6DvohA9+cVvfARViIVUuVLeie9x+Xaf2mDG22QRw
 OtW06eMfh4QsRO6opGDu1t6o3s8gGeNcxWlsZ0DjOhmxbgL51jpqwjsmQVxrN8B0q9h/FCRmPz3CuG5A6gjT53x/gffyZfl2ss+jup9tYYjOjZLUSQjXoaa+
 sYHh1OHSyhR57ikVoyPflIo3+CuiiH/XOvuTxDES2/araKc5rxiMIR7iNwLpkCReGpVso0dhaR+c7kJOQde8+XFeEysNyh8a3tt5eiCAtqDSdDHZ2R0thMeJ
 gzalX9fVnO7FRTwrPs00vHxHNfzvBs5ffIZUej6SiMpvYQgIO2wnZczH32oJUnC9eSgMZ1ezlwTJJsdk+DbrWt4G9QvrkQ==
X-CM-Analysis: v=2.4 cv=UM++oATy c=1 sm=1 tr=0 ts=64fa485d
 a=m0hBPjpnfWKpZW+YOe+Hqw==:117 a=m0hBPjpnfWKpZW+YOe+Hqw==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=0AOgk2NmGiZ_o05NmboA:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (142.198.135.111) by cmx-torrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 64E88507015705AD; Thu, 7 Sep 2023 18:02:05 -0400
Message-ID: <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
Date:   Thu, 7 Sep 2023 18:02:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] linux/export: fix reference to exported functions for
 parisc64
From:   John David Anglin <dave.anglin@bell.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230905190828.790400-1-masahiroy@kernel.org>
 <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
Content-Language: en-US
In-Reply-To: <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-05 7:59 p.m., John David Anglin wrote:
> On 2023-09-05 5:57 p.m., John David Anglin wrote:
>> I'll check ddb5cdbafaaa.
> Similar fault with ddb5cdbafaaa:
The alignment of the __kstrtab_ symbols in vmlinux seems wrong.  I'm fairly certain that function
references prefixed with P% on hppa64 need 8 byte alignment.

81662: 0000000040ea4358     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_system[...]
  81663: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_syst[...]
  81664: 0000000040e8e830     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_system[...]
  81665: 0000000040ea4365     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_static[...]
  81666: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_stat[...]
  81667: 0000000040ea1640     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_static[...]
  81668: 0000000040ea437c     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_reset_[...]
  81669: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_rese[...]
  81670: 0000000040e8bbc0     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_reset_[...]
  81671: 0000000040ea438a     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_loops_[...]
  81672: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_loop[...]
  81673: 0000000040e86610     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_loops_[...]
  81674: 0000000040ea439a     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_init_uts_ns
  81675: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_init[...]
  81676: 0000000040e99180     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_init_uts_ns
  81677: 0000000040ea43a6     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_name_t[...]
  81678: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_name[...]
  81679: 0000000040e9b340     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_name_t[...]
  81680: 0000000040ea43b4     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_wait_f[...]
  81681: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_wait[...]
  81682: 0000000040ea3638     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_wait_f[...]
  81683: 0000000040ea43c7     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_init_task
[...]

I'm not sure how we get symbols that aren't 8 byte aligned.  The ".balign 4" directive
in __KSYMTAB doesn't seem correct but it's not the whole problem.

Dave

-- 
John David Anglin  dave.anglin@bell.net

