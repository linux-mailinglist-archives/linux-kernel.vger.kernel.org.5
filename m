Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE19781835
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbjHSIFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344811AbjHSIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:04:35 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4FE170E;
        Sat, 19 Aug 2023 01:04:32 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: EFA5C2016B.AEE70
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id EFA5C2016B;
        Sat, 19 Aug 2023 10:04:28 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692432268;
        bh=zFVpONGFMy1tuCMIYS3uT4dliyO72X9mqpWn/qgFmpc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bPEK9qurfnUzTwEoaR8yaNeiJKxS4tQk2hBlyFmg55AO2v2p9YjodH+nFZsJvDHzO
         etQqQ+ZOWd4J5ngUai8M5Tcpys/jIhoWzS0/KMblJr5LnOF4Z7/5bFUQ1+7P5I8uk2
         4MELKfjH5yKLmXTAb6I+5g3XGVOD0tvKIQQN5ONs=
Received: from [192.168.44.147] (ptr-94-109-233-233.dyn.orange.be [94.109.233.233])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 65D5AD4E6A738;
        Sat, 19 Aug 2023 10:04:26 +0200 (CEST)
Message-ID: <150d8ca8-2c66-60d1-f9fc-8e6279824e94@cs.kuleuven.be>
Date:   Fri, 18 Aug 2023 19:30:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] selftests/sgx: Fix function pointer relocation in
 test enclave.
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-3-jo.vanbulck@cs.kuleuven.be>
 <8266f771d0d34317f1e9b10a3ac6a6e2e8c156d4.camel@intel.com>
 <f9c24d89-ed72-7d9e-c650-050d722c6b04@cs.kuleuven.be>
 <4c3005de1d6ed93df3dc57e2e285d4a6f42473bd.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <4c3005de1d6ed93df3dc57e2e285d4a6f42473bd.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.23 05:54, Huang, Kai wrote:
> How is the "prepared copy" prepared, exactly?  Could you paste the relevant code
> here too?  IMHO w/o it it's hard to tell whether the code could be wrong or not
> after relocating.

The "prepared copy" resides in .data and simply contains the absolute 
addresses of the functions (i.e., as they appear in objdump with .text 
starting at 0x2000).

Compiled with gcc -static -fPIC -Os, this looks as follows (the 
"prepared copy" starts at 0x5000, immediately following encl_buffer at 
the start of .data):

readelf -x .data test_encl.elf
   0x00005000 64200000 00000000 7a200000 00000000 d ......z ......
   0x00005010 90200000 00000000 a3200000 00000000 . ....... ......
   0x00005020 b6200000 00000000 24200000 00000000 . ......$ ......
   0x00005030 00200000 00000000 bb200000 00000000 . ....... ......

objdump -D test_encl.elf | grep do_encl_
   0000000000002000 <do_encl_emodpe>:
   0000000000002024 <do_encl_eaccept>:
   0000000000002064 <do_encl_op_put_to_buf>:
   000000000000207a <do_encl_op_get_from_buf>:
   0000000000002090 <do_encl_op_put_to_addr>:
   00000000000020a3 <do_encl_op_get_from_addr>:
   00000000000020b6 <do_encl_op_nop>:
   00000000000020bb <do_encl_init_tcs_page>:

For reference, the full encl_body code:

0000000000002175 <encl_body>:
     2175:       f3 0f 1e fa             endbr64
     2179:       49 89 f8                mov    %rdi,%r8
     217c:       48 8d 35 7d 2e 00 00    lea    0x2e7d(%rip),%rsi 
# 5000 <encl_buffer+0x2000>
     2183:       48 8d 7c 24 b8          lea    -0x48(%rsp),%rdi
     2188:       b9 10 00 00 00          mov    $0x10,%ecx
     218d:       f3 a5                   rep movsl %ds:(%rsi),%es:(%rdi)
     218f:       49 8b 00                mov    (%r8),%rax
     2192:       48 83 f8 07             cmp    $0x7,%rax
     2196:       77 0a                   ja     21a2 <encl_body+0x2d>
     2198:       48 8b 44 c4 b8          mov    -0x48(%rsp,%rax,8),%rax
     219d:       4c 89 c7                mov    %r8,%rdi
     21a0:       ff e0                   jmp    *%rax
     21a2:       c3                      ret

Thus, the "prepared copy" with _absolute_ function pointers is loaded 
from .data and copied onto the stack. The code then jumps to the 
_absolute_ function address loaded from the local copy, i.e., _without_ 
first properly relocating the loaded address.

> I am not sure whether all those 'rela.dyn' matters due to the reason you
> mentioned below ...
> 
>> Since the enclave loading process is
>> different and glibc is not included, we cannot rely on these relocations
>> to be performed and we need to do them manually.
>>
> 
> ... here.
> 
> Those relocation table are not used by enclave builder anyway.  Only ".tsc"
> ".text" and ".data" + some heap are built as enclave.

Yes, the relocation table is not used by the (untrusted) enclave 
builder, neither by a (trusted) initialization stub inside the enclave. 
Hence, this commit tries to address this by _manually_ relocating the 
(only) needed relocations.

>> Note: the first 4
>> symbols in the relocation table above are from the TCS initialization in
>> test_encl_bootstrap.S and should *not* be relocated (as these are
>> relative to enclave base as per SGX spec).
> 
> I don't quite follow here.  Per my understanding TCS pages can be any page
> within the enclave.  I don't quite understand what does "relocated" mean here.

Yes, the TCS can be any page in the enclave, as the architectural 
definitions are explicitly position-independent: OSSA and OENTRY are 
specified as a relative _offset_ to the enclave base runtime load address.

The thing is, these fields are initialized in test_encl_bootstrap.S as 
symbols to filled in by the linker:

         .section ".tcs", "aw"
         .balign 4096

         .fill   1, 8, 0                 # STATE (set by CPU)
         .fill   1, 8, 0                 # FLAGS
         .quad   encl_ssa_tcs1           # OSSA
         .fill   1, 4, 0                 # CSSA (set by CPU)
         .fill   1, 4, 1                 # NSSA
         .quad   encl_entry              # OENTRY
	/* snipped */

Thus, when compiling/linking with "-static-pie", the linker (obviously 
not aware of SGX TCS semantics) will treat these symbols as "normal" and 
recognize that they need to be relocated as they are absolute (non-RIP 
relative) references and places them in ".rela.dyn":

Relocation section '.rela.dyn' at offset 0x4000 contains 12 entries:
    Offset          Info           Type           Sym. Value    Sym. Name
+ Addend
# tcs1.ossa
000000000010  000000000008 R_X86_64_RELATIVE                    7000
# tcs1.oentry
000000000020  000000000008 R_X86_64_RELATIVE                    21e3

Thus, my earlier comment says that we can safely ignore these 
apparent/false TCS "relocations".

> I think we are kinda mixing two things together: 1) the "relocation" supported
> by the "non-enclave" normal case, where the compiler/linker generates the PIC
> code, and the loader does the "runtime" fixup for those in the "rela.dyn"; 2)
> the "relocation" for the enclave case, where the compiler/linker still generates
> the PIC code, but the "enclave loader" loads the enclave into a random virtual
> address of the process.
> 
> Obviously the "enclave loader" (implemented in this selftests/sgx/...) isn't as
> powerful as the "real loader" in the normal case.  In fact, reading the code,
> IIUC, it simply gathers ".tsc"/".text"/".data" sections from the ELF file (and
> plus some heap) and load them into the enclave.

Agreed, the "enclave loader" should simply copy the sections into EPC 
memory without being a "real loader". Particularly, it should *not* do 
any relocations as that would change the code and, hence, the MRENCLAVE 
signature.

> 
> Now the important thing is: those sections are "contiguous" in the enclave.
> That means the kernel needs to build the enclave ELF file with those sections
> "contiguously" in the same order too as a single piece, and this single piece
> can work at any random address that the "enclave loader" loads the enclave.  Any
> address fixing up due to different location of ".data"/".tsc" section at loading
> time cannot be generated.
> 
> This should be the thing that we need to focus on.
>

Agreed. That's why any _necessary_ relocations need to happen *inside* 
the enclave, by the application or a small initialization stub, such 
that the enclave MRENCLAVE identity is independent of its load address.

> That being said, I think ideally there shouldn't be _ANY_ "rela.dyn" in the
> enclave ELF file.

Agreed, this would be "ideal". However, I don't see a way to generate 
the function-pointer table without needing a runtime relocation. For all 
other code, we don't have to care about this and we can simply rely on 
-static-pie and -fPIE to emit RIP-relative code without needing 
relocations. Afais, when storing an address in a variable, a relocation 
is needed.

I agree though that we do *not* need a full .rela.dyn parser here and 
can simply manually relocate the only relevant case here, ie encl_op_array.

> I agree we should use "-static-pie" + "-fPIE" (or "-fPIC" is also OK??).

Not sure on the exact difference between -fPIE and -fPIC. I changed to 
-fPIE because gcc mentions in the documentation for "-static-pie" that:

For predictable results, you must also specify the same set of options 
used for compilation (-fpie, -fPIE, or model suboptions) when you 
specify this linker option.

> However I am yet not convinced the "relocate function-pointer" thing.  If you
> can paste the relevant code it would be helpful.

See above. Let me know if you'd like more context or the full binary.

> Or am I missing something big?

Nothing big, but, in my understanding, even PIE code may still need 
(limited) relocations, eg when storing (function-pointer) addresses in a 
C variable. This is normally taken care of by glibc on startup, but we 
need to do this manually here as implemented in this commit.

Best,
Jo
