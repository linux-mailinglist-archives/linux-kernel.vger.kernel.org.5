Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB875D120
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGUSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUSMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E212D46
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6144261D7E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 18:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD9BC433C9;
        Fri, 21 Jul 2023 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689963146;
        bh=zwAVSfqMsaViOE2l+fLRxL4U5WfWEegVlGnz/ddOkA8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MiRm00XeQfErWTMWCj1PXNbdS1GpYtaPRsWXFCXHA1TjWXLPS5qZ/P2KoKO2n4sOr
         sarZsbBUTLBV4VnbSvQL4O9lm4+IJtxHJM98GlaLo7DbNUTdNsTdkdjLd5gzgp2ufF
         26uFpeBdnuz6oZJbUGA7fz5JtW5W74WBAb7AzcgY+4Kjx5M3VgSl0mevMhWi3APwWf
         vmF3JCMB9smMDn8NV2RoQni94Zbjc46O2zbG6ldF2I+fjd7o2thzZ2tKehJtTkJse+
         vSJKksp8lR10iuVZ8Wc+D19jacocFCuY/tg1OTXvWclHXnW8Ra16/XlZ8V/6K3aTIs
         cVk5VZNjUzXVw==
Message-ID: <e35c16d2-c86c-8df2-8312-c8ab254d221a@kernel.org>
Date:   Fri, 21 Jul 2023 12:12:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v8.1 net-next 00/23] net/tcp: Add TCP-AO support
Content-Language: en-US
To:     Dmitry Safonov <dima@arista.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>
References: <20230721161916.542667-1-dima@arista.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230721161916.542667-1-dima@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 10:18 AM, Dmitry Safonov wrote:
> Hi,
> 
> This is version 8.1 of TCP-AO support. I base it on net-next as
> there's commit 5e5265522a9a ("tcp: annotate data-races around
> tcp_rsk(req)->txhash") which makes a minor conflict.
> 
> The good news is that all pre-required patches have merged to
> Torvald's/master. Thanks to Herbert, crypto clone-tfm just works on
> master for all TCP-AO supported algorithms.
> So, this is the first version of the patch set that has only net-related
> changes (well, selftests as well, but they'll be upstreamed separately).
> 
> In this version, I've finally spent time and written Documentation/ page
> on TCP-AO. It has Frequently Asked Questions (FAQ) on RFC 5925 - I found
> it very useful to answer those before writing the actual code.
> It provides answers to common questions that arise on a quick read of
> the RFC as well as how they were answered. There's also a comparison
> to the TCP-MD5 option, an evaluation of per-socket vs in-kernel-DB
> approaches and a description of uAPI provided.
> I hope it will be as useful for reviewing the code as it was for writing.
> 
> The most important changes in this version are:
> - CONFIG_TCP_AO implies CONFIG_IPV6 != m. I don't feel like that
>   combination would be useful to anyone and it'd be painful to fix.
> - uAPI change in TCP_AO_REPAIR (introduced in version 7): I removed
>   {snd,rcv}_sne_seq counters. They were just copies of snd_nxt/snd_una.
>   No reason for polluting uAPI as well as needlessly copying them.
> - TCP_AO_MAX_HASH_SIZE is removed and all temporary buffers are
>   kmalloc()'d. That also saves a couple of bytes for hmac(sha1) and
>   cmac(aes128) traffic keys as they now are allocated with
>   exact hash algo's digest_size.
> 
> There's an independent patch set for TCP-MD5 to verify segments on twsk:
> https://lore.kernel.org/all/20230509221608.2569333-1-dima@arista.com/T/#u
> That may be used to verify TCP-AO segments on twsk as well.
> 
> There seem to be more people that connected me off-list asking me about
> the status of patches and when I expect them to merge. Cc'ing more
> interested parties here (ping me directly if you don't want to be in
> copy). It would be helpful if you provide your reviews and tested-by's.
> As far as I'm aware, version 7 was ported to RHEL, so now there are
> probably more downstream kernels with TCP-AO support.
> 
> Also available as a git branch for pulling:
> https://github.com/0x7f454c46/linux/tree/tcp-ao-v8.1
> And another branch with selftests, that will be sent later separately:
> https://github.com/0x7f454c46/linux/tree/tcp-ao-v8-with-selftests
> 
> Thanks for your time and reviews,
>          Dmitry
> 
> --- Changelog ---
> 
> Changes from v8:
> - Rebased/retested on linux-net-next
> 
> Version 8: https://lore.kernel.org/all/20230719202631.472019-1-dima@arista.com/T/#u
> 
> Changes from v7:
> - Fixed copy'n'paste typo in unsigned-md5.c selftest output
> - Fix build error in tcp_v6_send_reset() (kernel test robot <lkp@intel.com>)
> - Make CONFIG_TCP_AO imply IPV6 != m
> - Cleanup EXPORT_SYMBOL*() as they aren't needed with IPV6 != m
> - Used scratch area instead of on-stack buffer for scatter-gather list
>   in tcp_v{4,6}_ao_calc_key(). Fixes CONFIG_VMAP_STACK=y + CONFIG_DEBUG_SG=y
> - Allocated digest_size'd buffers for traffic keys in tcp_ao_key instead
>   of maximum-sized buffers of TCP_AO_MAX_HASH_SIZE. That will save
>   little space per key and also potentially allow algorithms with
>   digest size > TCP_AO_MAX_HASH_SIZE.
> - Removed TCP_AO_MAX_HASH_SIZE and used kmalloc(GFP_ATOMIC) instead of
>   on-stack hash buffer.
> - Don't treat fd=0 as invalid in selftests
> - Make TCP-AO selftests work with CONFIG_CRYPTO_FIPS=y
> - Don't tcp_ao_compute_sne() for snd_sne on twsk: it's redundant as
>   no data can be sent on twsk
> - Get rid of {snd,rcv}_sne_seq: use snd_nxt/snd_una or rcv_nxt instead
> - {rcv,snd}_sne and tcp_ao_compute_sne() now are introduced in
>   "net/tcp: Add TCP-AO SNE support" patch
> - trivial copy_to_sockptr() fixup for tcp_ao_get_repair() - it could
>   try copying bigger struct than the kernel one (embarrassing!)
> - Added Documentation/networking/tcp_ao.rst that describes:
>   uAPI, has FAQ on RFC 5925 and has implementation details of Linux TCP-AO
> 
> Version 7: https://lore.kernel.org/all/20230614230947.3954084-1-dima@arista.com/T/#u
> 
> Changes from v6:
> - Some more trivial build warnings fixups (kernel test robot <lkp@intel.com>)
> - Added TCP_AO_REPAIR setsockopt(), getsockopt()
> - Allowed TCP_AO_* setsockopts if (tp->repair) is on
> - Added selftests for TCP_AO_REPAIR, that also check incorrect
>   ISNs/SNEs, which result in a broken TCP-AO connection - that verifies
>   that both Initial Sequence Numbers and Sequence Number Extension are
>   part of MAC generation
> - Using TCP_AO_REPAIR added a selftest for SEQ numbers rollover,
>   checking that SNE was incremented, connection is alive post-rolloever
>   and no TCP segments with a wrong signature arrived
> - Wrote a selftest for RST segments: both active reset (goes through
>   transmit_skb()) and passive reset (goes through tcp_v{4,6}_send_reset()).
> - Refactored and made readable tcp_v{4,6}_send_reset(), also adding
>   support for TCP_LISTEN/TCP_NEW_SYN_RECV
> - Dropped per-CPU ahash requests allocations in favor of Herbert's
>   clone-tfm crypto API
> - Added Donald Cassidy to Cc as he's interested in getting it into RHEL.
> 
> Version 6: https://lore.kernel.org/all/20230512202311.2845526-1-dima@arista.com/T/#u
> 
> iperf[3] benchmarks for version 6:
>                            v6.4-rc1                 TCP-AO-v6
>   TCP                      43.9 Gbits/sec           43.5 Gbits/sec
>   TCP-MD5                  2.20 Gbits/sec           2.25 Gbits/sec
>   TCP-AO(hmac(sha1))                                2.53 Gbits/sec
>   TCP-AO(hmac(sha512))                              1.67 Gbits/sec
>   TCP-AO(hmac(sha384))                              1.77 Gbits/sec
>   TCP-AO(hmac(sha224))                              1.29 Gbits/sec
>   TCP-AO(hmac(sha3-512))                             481 Mbits/sec
>   TCP-AO(hmac(md5))                                 2.07 Gbits/sec
>   TCP-AO(hmac(rmd160))                              1.01 Gbits/sec
>   TCP-AO(cmac(aes128))                              2.11 Gbits/sec
> 
> Changes from v5:
> - removed check for TCP_AO_KEYF_IFINDEX in delete command:
>   VRF might have been destroyed, there still needs to be a way to delete
>   keys that were bound to that l3intf (should tcp_v{4,6}_parse_md5_keys()
>   avoid the same check as well?)
> - corrected copy'n'paste typo in tcp_ao_info_cmd() (assign ao_info->rnext_key)
> - simplified a bit tcp_ao_copy_mkts_to_user(); added more UAPI checks
>   for getsockopt(TCP_AO_GET_KEYS)
> - More UAPI selftests in setsockopt-closed: 29 => 120
> - ported TCP-AO patches on Herbert's clone-tfm changes
> - adjusted iperf patch for TCP-AO UAPI changes from version 5
> - added measures for TCP-AO with tcp_sigpool & clone_tfm backends
> 
> Version 5: https://lore.kernel.org/all/20230403213420.1576559-1-dima@arista.com/T/#u
> 
> Changes from v4:
> - Renamed tcp_ao_matched_key() => tcp_ao_established_key()
> - Missed `static` in function definitions
>   (kernel test robot <lkp@intel.com>)
> - Fixed CONFIG_IPV6=m build
> - Unexported tcp_md5_*_sigpool() functions
> - Cleaned up tcp_ao.h: undeclared tcp_ao_cache_traffic_keys(),
>   tcp_v4_ao_calc_key_skb(); removed tcp_v4_inbound_ao_hash()
> - Marked "net/tcp: Prepare tcp_md5sig_pool for TCP-AO" as a [draft] patch
> - getsockopt() now returns TCP-AO per-key counters
> - Another getsockopt() now returns per-ao_info stats: counters
>   and accept_icmps flag state
> - Wired up getsockopt() returning counters to selftests
> - Fixed a porting mistake: TCP-AO hash in some cases was written in TCP
>   header without accounting for MAC length of the key, rewritting skb
>   shared info
> - Fail adding a key with L3 ifindex when !TCP_AO_KEYF_IFINDEX, instead
>   of ignoring tcpa_ifindex (stricter UAPI check)
> - Added more test-cases to setsockopt-closed.c selftest
> - tcp_ao_hash_skb_data() was a copy'n'paste of tcp_md5_hash_skb_data()
>   share it now under tcp_sigpool_hash_skb_data()
> - tcp_ao_mkt_overlap_v{4,6}() deleted as they just re-invented
>   tcp_ao_do_lookup(). That fixes an issue with multiple IPv4-mapped-IPv6
>   keys for different peers on a listening socket.
> - getsockopt() now is tested to return correct VRF number for a key
> - TCP-AO and TCP-MD5 interraction in non/default VRFs: added +19 selftests
>   made them SKIP when CONFIG_VRF=n
> - unsigned-md5 selftests now checks both scenarios:
>   (1) adding TCP-AO key _after_ TCP-MD5 key
>   (2) adding TCP-MD5 key _after_ TCP-AO key
> - Added a ratelimited warning if TCP-AO key.ifindex doesn't match
>   sk->sk_bound_dev_if - that will warn a user for potential VRF issues
> - tcp_v{4,6}_parse_md5_keys() now allows adding TCP-MD5 key with
>   ifindex=0 and TCP_MD5SIG_FLAG_IFINDEX together with TCP-AO key from
>   another VRF
> - Add TCP_AO_CMDF_AO_REQUIRED, which makes a socket TCP-AO only,
>   rejecting TCP-MD5 keys or any unsigned TCP segments
> - Remove `tcpa_' prefix for UAPI structure members
> - UAPI cleanup: I've separated & renamed per-socket settings
>   (such as ao_info flags + current/rnext set) from per-key changes:
>   TCP_AO     => TCP_AO_ADD_KEY
>   TCP_AO_DEL => TCP_AO_DEL_KEY
>   TCP_AO_GET => TCP_AO_GET_KEYS
>   TCP_AO_MOD => TCP_AO_INFO, the structure is now valid for both
>                 getsockopt() and setsockopt().
> - tcp_ao_current_rnext() was split up in order to fail earlier when
>   sndid/rcvid specified can't be set, before anything was changed in ao_info
> - fetch current_key before dumping TCP-AO keys in getsockopt(TCP_AO_GET_KEYS):
>   it may race with changing current_key by RX, which in result might
>   produce a dump with no current_key for userspace.
> - instead of TCP_AO_CMDF_* flags, used bitfileds: the flags weren't
>   shared between all TCP_AO_{ADD,GET,DEL}_KEY{,S}, so bitfields are more
>   descriptive here
> - use READ_ONCE()/WRITE_ONCE() for current_key and rnext_key more
>   consistently; document in comment the rules for accessing them
> - selftests: check all setsockopts()/getsockopts() support extending
>   option structs
> 
> Version 4: https://lore.kernel.org/all/20230215183335.800122-1-dima@arista.com/T/#u
> 
> Changes from v3:
> - TCP_MD5 dynamic static key enable/disable patches merged separately [4]
> - crypto_pool patches were nacked [5], so instead this patch set extends
>   TCP-MD5-sigpool to be used for TCP-AO as well as for TCP-MD5
> - Added missing `static' for tcp_v6_ao_calc_key()
>   (kernel test robot <lkp@intel.com>)
> - Removed CONFIG_TCP_AO default=y and added "If unsure, say N."
> - Don't leak ao_info and don't create an unsigned TCP socket if there was
>   a TCP-AO key during handshake, but it was removed from listening socket
>   while the connection was being established
> - Migrate to use static_key_fast_inc_not_disabled() and check return
>   code of static_branch_inc()
> - Change some return codes to EAFNOSUPPORT for error-pathes where
>   family is neither AF_INET nor AF_INET6
> - setsockopt()s on a closed/listen socket might have created stray ao_info,
>   remove it if connect() is called with a correct TCP-MD5 key, the same
>   for the reverse situation: remove md5sig_info straight away from the
>   socket if it's going to be TCP-AO connection
> - IPv4-mapped-IPv6 addresses + selftest in fcnal-test.sh (by Salam)
> - fix using uninitialized sisn/disn from stack - it would only make
>   non-SYN packets fail verification on a listen socket, which are not
>   expected anyway (kernel test robot <lkp@intel.com>)
> - implicit padding in UAPI TCP-AO structures converted to explicit
>   (spotted-by David Laight)
> - Some selftests missed zero-initializers for uapi structs on stack
> - Removed tcp_ao_do_lookup_rcvid() and tcp_ao_do_lookup_sndid() in
>   favor of unified tcp_ao_matched_key()
> - Disallowed setting current/rnext keys on listen sockets - that wasn't
>   supported and didn't affect anything, cleanup for the UAPI
> - VRFs support for TCP-AO
> 
> Version 3: https://lore.kernel.org/all/20221027204347.529913-1-dima@arista.com/T/#u
> 
> Changes from v2:
> - Added more missing `static' declarations for local functions
>   (kernel test robot <lkp@intel.com>)
> - Building now with CONFIG_TCP_AO=n and CONFIG_TCP_MD5SIG=n
>   (kernel test robot <lkp@intel.com>)
> - Now setsockopt(TCP_AO) is allowed when it's TCP_LISTEN or TCP_CLOSE
>   state OR the key added is not the first key on a socket (by Salam)
> - CONFIG_TCP_AO does not depend on CONFIG_TCP_MD5SIG anymore
> - Don't leak tcp_md5_needed static branch counter when TCP-MD5 key
>   is modified/changed
> - TCP-AO lookups are dynamically enabled/disabled with static key when
>   there is ao_info in the system (and when it is destroyed)
> - Wired SYN cookies up to TCP-AO (by Salam)
> - Fix verification for possible re-transmitted SYN packets (by Salam)
> - use sockopt_lock_sock() instead of lock_sock()
>   (from v6.1 rebase, commit d51bbff2aba7)
> - use sockptr_t in getsockopt(TCP_AO_GET)
>   (from v6.1 rebase, commit 34704ef024ae)
> - Fixed reallocating crypto_pool's scratch area by IPI while
>   crypto_pool_get() was get by another CPU
> - selftests on older kernels (or with CONFIG_TCP_AO=n) should exit with
>   SKIP, not FAIL (Shuah Khan <shuah@kernel.org>)
> - selftests that check interaction between TCP-AO and TCP-MD5 now
>   SKIP when CONFIG_TCP_MD5SIG=n
> - Measured the performance of different hashing algorithms for TCP-AO
>   and compare with TCP-MD5 performance. This is done with hacky patches
>   to iperf (see [3]). At this moment I've done it in qemu/KVM with CPU
>   affinities set on Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz.
>   No performance degradation was noticed before/after patches, but given
>   the measures were done in a VM, without measuring it on a physical dut
>   it only gives a hint of relative speed for different hash algorithms
>   with TCP-AO. Here are results, averaging on 30 measures each:
>   TCP:                    3.51Gbits/sec
>   TCP-MD5:                1.12Gbits/sec
>   TCP-AO(HMAC(SHA1)):     1.53Gbits/sec
>   TCP-AO(CMAC(AES128)):   621Mbits/sec
>   TCP-AO(HMAC(SHA512)):   1.21Gbits/sec
>   TCP-AO(HMAC(SHA384)):   1.20Gbits/sec
>   TCP-AO(HMAC(SHA224)):   961Mbits/sec
>   TCP-AO(HMAC(SHA3-512)): 157Mbits/sec
>   TCP-AO(HMAC(RMD160)):   659Mbits/sec
>   TCP-AO(HMAC(MD5):       1.12Gbits/sec
>   (the last one is just for fun, but may make sense as it provides
>   the same security as TCP-MD5, but allows multiple keys and a mechanism
>   to change them from RFC5925)
> 
> Version 2: https://lore.kernel.org/all/20220923201319.493208-1-dima@arista.com/T/#u
> 
> Changes from v1:
> - Building now with CONFIG_IPV6=n (kernel test robot <lkp@intel.com>)
> - Added missing static declarations for local functions
>   (kernel test robot <lkp@intel.com>)
> - Addressed static analyzer and review comments by Dan Carpenter
>   (thanks, they were very useful!)
> - Fix elif without defined() for !CONFIG_TCP_AO
> - Recursively build selftests/net/tcp_ao (Shuah Khan), patches in:
>   https://lore.kernel.org/all/20220919201958.279545-1-dima@arista.com/T/#u
> - Don't leak crypto_pool reference when TCP-MD5 key is modified/changed
> - Add TCP-AO support for nettest.c and fcnal-test.sh
>   (will be used for VRF testing in later versions)
> 
> Comparison between Leonard proposal and this (overview):
> https://lore.kernel.org/all/3cf03d51-74db-675c-b392-e4647fa5b5a6@arista.com/T/#u
> 
> Version 1: https://lore.kernel.org/all/20220818170005.747015-1-dima@arista.com/T/#u
> 
> This patchset implements the TCP-AO option as described in RFC5925. There
> is a request from industry to move away from TCP-MD5SIG and it seems the time
> is right to have a TCP-AO upstreamed. This TCP option is meant to replace
> the TCP MD5 option and address its shortcomings. Specifically, it provides
> more secure hashing, key rotation and support for long-lived connections
> (see the summary of TCP-AO advantages over TCP-MD5 in (1.3) of RFC5925).
> The patch series starts with six patches that are not specific to TCP-AO
> but implement a general crypto facility that we thought is useful
> to eliminate code duplication between TCP-MD5SIG and TCP-AO as well as other
> crypto users. These six patches are being submitted separately in
> a different patchset [1]. Including them here will show better the gain
> in code sharing. Next are 18 patches that implement the actual TCP-AO option,
> followed by patches implementing selftests.
> 
> The patch set was written as a collaboration of three authors (in alphabetical
> order): Dmitry Safonov, Francesco Ruggeri and Salam Noureddine. Additional
> credits should be given to Prasad Koya, who was involved in early prototyping
> a few years back. There is also a separate submission done by Leonard Crestez
> whom we thank for his efforts getting an implementation of RFC5925 submitted
> for review upstream [2]. This is an independent implementation that makes
> different design decisions.
> 
> For example, we chose a similar design to the TCP-MD5SIG implementation and
> used setsockopts to program per-socket keys, avoiding the extra complexity
> of managing a centralized key database in the kernel. A centralized database
> in the kernel has dubious benefits since it doesn’t eliminate per-socket
> setsockopts needed to specify which sockets need TCP-AO and what are the
> currently preferred keys. It also complicates traffic key caching and
> preventing deletion of in-use keys.
> 
> In this implementation, a centralized database of keys can be thought of
> as living in user space and user applications would have to program those
> keys on matching sockets. On the server side, the user application programs
> keys (MKTS in TCP-AO nomenclature) on the listening socket for all peers that
> are expected to connect. Prefix matching on the peer address is supported.
> When a peer issues a successful connect, all the MKTs matching the IP address
> of the peer are copied to the newly created socket. On the active side,
> when a connect() is issued all MKTs that do not match the peer are deleted
> from the socket since they will never match the peer. This implementation
> uses three setsockopt()s for adding, deleting and modifying keys on a socket.
> All three setsockopt()s have extensive sanity checks that prevent
> inconsistencies in the keys on a given socket. A getsockopt() is provided
> to get key information from any given socket.
> 
> Few things to note about this implementation:
> - Traffic keys are cached for established connections avoiding the cost of
>   such calculation for each packet received or sent.
> - Great care has been taken to avoid deleting in-use MKTs
>   as required by the RFC.
> - Any crypto algorithm supported by the Linux kernel can be used
>   to calculate packet hashes.
> - Fastopen works with TCP-AO but hasn’t been tested extensively.
> - Tested for interop with other major networking vendors (on linux-4.19),
>   including testing for key rotation and long lived connections.
> 
> [1]: https://lore.kernel.org/all/20220726201600.1715505-1-dima@arista.com/
> [2]: https://lore.kernel.org/all/cover.1658815925.git.cdleonard@gmail.com/
> [3]: https://github.com/0x7f454c46/iperf/tree/tcp-md5-ao
> [4]: https://lore.kernel.org/all/166995421700.16716.17446147162780881407.git-patchwork-notify@kernel.org/T/#u
> [5]: https://lore.kernel.org/all/Y8kSkW4X4vQdFyOl@gondor.apana.org.au/T/#u
> [6]: https://lore.kernel.org/all/ZDefxOq6Ax0JeTRH@gondor.apana.org.au/T/#u
> 

For the set:
Acked-by: David Ahern <dsahern@kernel.org>

