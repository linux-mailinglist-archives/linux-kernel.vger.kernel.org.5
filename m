Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B0A771B47
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjHGHN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHGHN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:13:57 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25666E78;
        Mon,  7 Aug 2023 00:13:52 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 3B0E7201BD.AA15B
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 3B0E7201BD;
        Mon,  7 Aug 2023 09:13:48 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691392428;
        bh=gIktZW56BAAsvZmi5wGubvJ4GH7FhM0DcznVrv4QD24=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ju6ydbRi+jJ3IFEfgBgwTkEYqibKIpn12ulwtuv3NpMDToqxJXALLT8VrQC+Vzh2P
         6iYvNhlo4z4AU/W+cJdfe3oF00TOoG7P4EMAeJf7+0ttWAF3SKTAcFowjZEBObVOYo
         GlFOA8jJv+uj2OZ7aiuPoJyavZo216UpDptaQZpk=
Received: from [10.101.1.242] (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id C9826D4F79DD9;
        Mon,  7 Aug 2023 09:13:44 +0200 (CEST)
Message-ID: <f9c24d89-ed72-7d9e-c650-050d722c6b04@cs.kuleuven.be>
Date:   Mon, 7 Aug 2023 09:13:42 +0200
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
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <8266f771d0d34317f1e9b10a3ac6a6e2e8c156d4.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 05:58, Huang, Kai wrote:
> Putting aside whether we should consider building the selftests using "-Os", it
> would be helpful to explain how can the "-Os" break the existing code, so that
> we can review why this fix is reasonable.  Perhaps it's obvious to others but
> it's not obvious to me what can go wrong here.

I dug deeper into this and the real problem here is that the enclave ELF 
is linked with -static but also needs to be relocatable, which, in my 
understanding, is not what -static is meant for (i.e., the man pages 
says -static overrides -pie). Particularly, with -static I noticed that 
global variables are hard-coded assuming the ELF is loaded at base 
address zero.

When reading more on this, it seems like the proper thing to do for 
static and relocatable binaries is to compile with -static-pie, which is 
added since gcc 8 [1] (and similarly supported by clang).

As a case in point, to hopefully make this clearer, consider the 
following C function:

extern uint8_t __enclave_base;
void *get_base(void) {
	return &__enclave_base;
}

Compiling with -static and -fPIC hard codes the __enclave_base symbol to 
zero (the start of the ELF enclave image):

00000000000023f4 <get_base>:
     23f4:	f3 0f 1e fa          	endbr64
     23f8:	55                   	push   %rbp
     23f9:	48 89 e5             	mov    %rsp,%rbp
     23fc:	48 c7 c0 00 00 00 00 	mov    $0x0,%rax
     2403:	5d                   	pop    %rbp
     2404:	c3                   	ret

Compiling with -static-pie and -fPIE properly emits a RIP-relative address:

00000000000023f4 <get_base>:
     23f4:	f3 0f 1e fa          	endbr64
     23f8:	55                   	push   %rbp
     23f9:	48 89 e5             	mov    %rsp,%rbp
     23fc:	48 8d 05 fd db ff ff 	lea    -0x2403(%rip),%rax        # 0 
<__enclave_base>
     2403:	5d                   	pop    %rbp
     2404:	c3                   	ret

Now, the fact that it currently *happens* to work is a mere coincidence 
of how the local encl_op_array initialization is compiled without 
optimizations with -static -fPIC:

00000000000023f4 <encl_body>:
     /* snipped */
     2408:       48 8d 05 ec fe ff ff    lea    -0x114(%rip),%rax 
# 22fb <do_encl_op_put_to_buf>
     240f:       48 89 45 b0             mov    %rax,-0x50(%rbp)
     2413:       48 8d 05 18 ff ff ff    lea    -0xe8(%rip),%rax 
# 2332 <do_encl_op_get_from_buf>
     241a:       48 89 45 b8             mov    %rax,-0x48(%rbp)
     241e:       48 8d 05 44 ff ff ff    lea    -0xbc(%rip),%rax 
# 2369 <do_encl_op_put_to_addr>
     /* snipped */

When compiling with optimizations with -static -fPIC -Os, encl_op_array 
is instead initialized with a prepared copy from .data:

00000000000021b5 <encl_body>:
     /* snipped */
     21bc:       48 8d 35 3d 2e 00 00    lea    0x2e3d(%rip),%rsi 
# 5000 <encl_buffer+0x2000>
     21c3:       48 8d 7c 24 b8          lea    -0x48(%rsp),%rdi
     21c8:       b9 10 00 00 00          mov    $0x10,%ecx
     21cd:       f3 a5                   rep movsl %ds:(%rsi),%es:(%rdi)
     /* snipped */

Thus, in this optimized code, encl_op_array will have function pointers 
that are *not* relocated. The compilation assumes the -static binary has 
base address zero and is not relocatable:

$ readelf -r test_encl.elf

There are no relocations in this file.

When compiling with -static-pie -PIE -Os, the same code is emitted *but* 
the binary is relocatable:

$ readelf -r test_encl.elf

Relocation section '.rela.dyn' at offset 0x4000 contains 12 entries:
   Offset          Info           Type           Sym. Value    Sym. Name 
+ Addend
# tcs1.ossa
000000000010  000000000008 R_X86_64_RELATIVE                    7000
# tcs1.oentry
000000000020  000000000008 R_X86_64_RELATIVE                    21e3
# tcs2.ossa
000000001010  000000000008 R_X86_64_RELATIVE                    8000
# tcs2.oentry
000000001020  000000000008 R_X86_64_RELATIVE                    21e3
# encl_op_array
000000006000  000000000008 R_X86_64_RELATIVE                    2098
000000006008  000000000008 R_X86_64_RELATIVE                    20ae
000000006010  000000000008 R_X86_64_RELATIVE                    20c4
000000006018  000000000008 R_X86_64_RELATIVE                    20d7
000000006020  000000000008 R_X86_64_RELATIVE                    20ea
000000006028  000000000008 R_X86_64_RELATIVE                    203e
000000006030  000000000008 R_X86_64_RELATIVE                    2000
000000006038  000000000008 R_X86_64_RELATIVE                    20ef

Apparently, for static-pie binaries, glibc includes a 
_dl_relocate_static_pie routine that will perform the relocations as 
part of the startup [2,3]. Since the enclave loading process is 
different and glibc is not included, we cannot rely on these relocations 
to be performed and we need to do them manually. Note: the first 4 
symbols in the relocation table above are from the TCS initialization in 
test_encl_bootstrap.S and should *not* be relocated (as these are 
relative to enclave base as per SGX spec).

Bottom line: the way I see it, the enclave should either ensure no 
relocations are needed, or perform the relocations manually where 
needed, or include a _dl_relocate_static_pie equivalent that parses the 
.rela.dyn ELF section and patches all relocations (minus the TCS 
symbols). Since the latter (most general) approach is likely going to 
make the selftest enclave unnecessarily complex by including ELF parsing 
etc, I propose to simply relocate the function-pointer table manually 
(which is indeed the only place that needs relocations).

I will include code to properly compile the selftest enclave with 
-static-pie as per above and relocate the function-pointer table in the 
next patch revision.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81498
[2] https://stackoverflow.com/a/62587156
[3] 
https://sourceware.org/git/?p=glibc.git;a=blob;f=elf/dl-reloc-static-pie.c;h=382482fa739f10934aeb916650c65a4db231c481;hb=HEAD
