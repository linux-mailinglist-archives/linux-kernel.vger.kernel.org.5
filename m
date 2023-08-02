Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDC76DB9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjHBXdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBXdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:33:11 -0400
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 16:33:10 PDT
Received: from newman.cs.utexas.edu (newman.cs.utexas.edu [128.83.139.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5319BE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 16:33:09 -0700 (PDT)
X-AuthUser: ysohail
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1691018783;
        bh=jezoec35LIPHQGp7NRCcRqZwNvqa3eRC0vUme+DyUOQ=;
        h=Date:Subject:References:From:To:In-Reply-To:From;
        b=lUrJDCMoio5wnlgZjyYi3t/D5xVJh/urOj43OTYqLug2phQBd2QYqQ9ZPUMvJTOxB
         ne4L5DCSiwE6iGzNW1TNOLdGVeL68mhPmHQNa3FzROXZ5j+z6QMrY8e37KbhlGJANY
         5jrKTJbeW+fTOS5RRtYfz0yEOQWzR4nvW2XmLCrA=
Received: from [192.168.0.202] (71-138-92-128.lightspeed.hstntx.sbcglobal.net [71.138.92.128])
        (authenticated bits=0)
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id 372NQMqi005047
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 2 Aug 2023 18:26:22 -0500
Message-ID: <1126dfcc-50d1-e4ed-12a3-d48e6b6a1bbe@cs.utexas.edu>
Date:   Wed, 2 Aug 2023 18:26:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: x86 64-bit Entrypoint
Content-Language: en-US
References: <ec3ce891-5a9f-c0b0-1a1e-1d66bb8e3623@cs.utexas.edu>
From:   Yahya Sohail <ysohail@cs.utexas.edu>
To:     linux-kernel@vger.kernel.org
In-Reply-To: <ec3ce891-5a9f-c0b0-1a1e-1d66bb8e3623@cs.utexas.edu>
X-Forwarded-Message-Id: <ec3ce891-5a9f-c0b0-1a1e-1d66bb8e3623@cs.utexas.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Wed, 02 Aug 2023 18:26:23 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.103.8 at newman
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've read the documentation for the x86 boot protocol at 
Documentation/arch/x86/boot.rst. It states the following:
> In 64-bit boot protocol, the kernel is started by jumping to the
> 64-bit kernel entry point, which is the start address of loaded
> 64-bit kernel plus 0x200.

When I build a kernel and check the bytes at 0x200, they have the 
following disassembly:
0x00000200      eb6a           jmp 0x26c

The bytes at 0x26c disassemble as follows:
0x0000026c      8cd8           mov eax, ds
0x0000026e      8ec0           mov es, eax
0x00000270      fc             cld
0x00000271      8cd2           mov edx, ss
0x00000273      39c2           cmp edx, eax
0x00000275      89e2           mov edx, esp
0x00000277      7416           je 0x28f
0x00000279      ba204df606     mov edx, 0x6f64d20
0x0000027e      1102           adc dword [rdx], eax
0x00000280      8074048b16     xor byte [rsp + rax - 0x75], 0x16
0x00000285      2402           and al, 2
0x00000287      81c200047302   add edx, 0x2730400
0x0000028d      31d2           xor edx, edx
0x0000028f      83e2fc         and edx, 0xfffffffc
0x00000292      7503           jne 0x297
0x00000294      bafcff8ed0     mov edx, 0xd08efffc
0x00000299      660fb7e2       movzx sp, dx
0x0000029d      fb             sti
0x0000029e      1e             invalid

Notice the invalid opcode at 0x29e. In 32-bit mode 0x1e would be PUSH 
DS, but it is invalid in 64-bit mode. It appears the 64-bit entrypoint 
is invalid. Are the docs out of date?

Thanks,
Yahya Sohail
