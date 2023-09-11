Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7676C79C35B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbjILCyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbjILCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:53:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04483218DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:19:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52e64bc7c10so6610086a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1694481587; x=1695086387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFc2i5Fqjl4fzWwjBD1Dhd5aIy7X3tCnmeyC4tIUcFw=;
        b=gcS6qQo06wHMtFzmJORVemwJO7X+8e+9/jsSWUPNw4siEDk4wUknI2xLaiNn7BqDql
         zhO2Z/3xOojlgr1ZUtrutrqPhyOoIVLo1kv0yFBuZluXdSEze37HTfDNm7c6sMvVmvNw
         V+zrX1yJOXMfkwFDa+Y5oDpXPhAddnwAEvzuLJghmDs9mo0Y/cE1e/Y9uubtKtwa4+sy
         cOBJPsOeqVifr41g8MPT54t3FcuoR1C2Tg4iPZEdWtoT3nG5EjkQe2c+lJcxtyQVEPy1
         wR7bhf1xPCABQEb6VHAv4L0G31ijADM08sJ0bTCyMUz0oW10V+Ez5r3bP04sBDkDBR/n
         BJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694481587; x=1695086387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFc2i5Fqjl4fzWwjBD1Dhd5aIy7X3tCnmeyC4tIUcFw=;
        b=s8zdm7H20LHZi5uad6QOKXhMLkbQ5lRPrg7gRNGXzQC1J183mau7h4egoel0FtG78S
         cfWRh2z/eHJ480T1HxnAB+O+VT26cttLjlOpsRUehU9CYJvHWUNr/At3qPe7NrmnEw3d
         w+fkUySqC9t9g0EESGB6UwVIIgaXZNOFQwMMlLEM2gAtDDgV0een2WyCGYTCNRdQ+zZQ
         Ql2XQnYOu6H0Vp2yZ67iqMO/kykWSvi7KeJI5CUy5nssZphAjOb9Kot+9kAuXCQ3DT/k
         Cu5thPOej0LFjLI5aUeJ34fwz3YDNhPZJZbHjboOZjLBTSOmXROWpP/xBviB962xxzQl
         VDFA==
X-Gm-Message-State: AOJu0YxESblzPgNFtXRpEd5t4Zqmhi5EfSfgnDDtX9f4vK9cWkbkSJR1
        sjEdEgzSVlC4SPrumD/ZVsJ20l4q13eMOYwjgOo=
X-Google-Smtp-Source: AGHT+IFWGZZ+pU/pdiJ9G3ZO7aeZTDOVGGW+oLGQkYo5K3mB3Ab+qJGoWGaCHykau0VED3tmlgPa+g==
X-Received: by 2002:a7b:cd15:0:b0:401:cb45:3fb8 with SMTP id f21-20020a7bcd15000000b00401cb453fb8mr9060198wmj.38.1694466234255;
        Mon, 11 Sep 2023 14:03:54 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b00402e942561fsm14261699wmf.38.2023.09.11.14.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:03:53 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
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
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v11 net-next 00/23] net/tcp: Add TCP-AO support
Date:   Mon, 11 Sep 2023 22:03:20 +0100
Message-ID: <20230911210346.301750-1-dima@arista.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 11 of TCP-AO support. The chages from v10 address
Simon's review comments.

There's one Sparse warning introduced by tcp_sigpool_start():
__cond_acquires() seems to currently being broken. I've described
the reasoning for it on v9 cover letter. Also, checkpatch.pl warnings
were addressed, but yet I've left the ones that are more personal
preferences (i.e. 80 columns limit). Please, ping me if you have
a strong feeling about one of them.

The following changes since commit 73be7fb14e83d24383f840a22f24d3ed222ca319:

  Merge tag 'net-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-09-07 18:33:07 -0700)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-v11

for you to fetch changes up to 43b9bbf84d46412054f8a30a0085b7af15855703:

  Documentation/tcp: Add TCP-AO documentation (2023-09-11 20:16:20 +0100)

----------------------------------------------------------------

And another branch with selftests, that will be sent later separately:
  git@github.com:0x7f454c46/linux.git tcp-ao-v11-with-selftests

Thanks for your time and reviews,
         Dmitry

--- Changelog ---

Changes from v10:
- Make seq (u32) in tcp_ao_prepare_reset() and declare the argument
  in "net/tcp: Add TCP-AO SNE support", where it gets used (Simon)
- Fix rebase artifact in tcp_v6_reqsk_send_ack(), which adds
  compile-error on a patch in the middle of series (Simon)
- Another rebase artifact in tcp_v6_reqsk_send_ack() that makes
  keyid, requested by peer on ipv6 reqsk ACKs not respected (Simon)

Version 10: https://lore.kernel.org/all/20230815191455.1872316-1-dima@arista.com/T/#u

Changes from v9:
- Read sk_family only once in tcp_ao_ignore_icmp() (Eric)
- Don't WARN_ON_ONCE() on unexpected sk_family (Eric)
- Call tcp_ao_ignore_icmp() outside bh_lock_sock() (Eric)
- Make struct sock *sk `const' in tcp_ao_ignore_icmp() (Eric)
- WRITE_ONCE() for tcp_md5_sigpool_id (Eric)
- Cc Mohammad, who wants to contribute with PPC testing, reviews, etc

Version 9: https://lore.kernel.org/all/20230802172654.1467777-1-dima@arista.com/T/#u

Changes from v8:
- Based on net-next
- Now doing git request-pull, rather than GitHub URLs
- Fix tmp_key buffer leak, introduced in v7 (Simon)
- More checkpatch.pl warning fixes (even to the code that existed but
  was touched)
- More reverse Xmas tree declarations (Simon)
- static code analysis fixes
- Removed TCP-AO key port matching code
- Removed `inline' for for static functions in .c files to make
  netdev/source_inline happy (I didn't know it's a thing)
- Moved tcp_ao_do_lookup() to a commit that uses it (Simon)
- __tcp_ao_key_cmp(): prefixlen is bits, but memcmp() uses bytes
- Added TCP port matching limitation to Documentation/networking/tcp_ao.rst

Version 8: https://lore.kernel.org/all/20230719202631.472019-1-dima@arista.com/T/#u

Changes from v7:
- Fixed copy'n'paste typo in unsigned-md5.c selftest output
- Fix build error in tcp_v6_send_reset() (kernel test robot <lkp@intel.com>)
- Make CONFIG_TCP_AO imply IPV6 != m
- Cleanup EXPORT_SYMBOL*() as they aren't needed with IPV6 != m
- Used scratch area instead of on-stack buffer for scatter-gather list
  in tcp_v{4,6}_ao_calc_key(). Fixes CONFIG_VMAP_STACK=y + CONFIG_DEBUG_SG=y
- Allocated digest_size'd buffers for traffic keys in tcp_ao_key instead
  of maximum-sized buffers of TCP_AO_MAX_HASH_SIZE. That will save
  little space per key and also potentially allow algorithms with
  digest size > TCP_AO_MAX_HASH_SIZE.
- Removed TCP_AO_MAX_HASH_SIZE and used kmalloc(GFP_ATOMIC) instead of
  on-stack hash buffer.
- Don't treat fd=0 as invalid in selftests
- Make TCP-AO selftests work with CONFIG_CRYPTO_FIPS=y
- Don't tcp_ao_compute_sne() for snd_sne on twsk: it's redundant as
  no data can be sent on twsk
- Get rid of {snd,rcv}_sne_seq: use snd_nxt/snd_una or rcv_nxt instead
- {rcv,snd}_sne and tcp_ao_compute_sne() now are introduced in
  "net/tcp: Add TCP-AO SNE support" patch
- trivial copy_to_sockptr() fixup for tcp_ao_get_repair() - it could
  try copying bigger struct than the kernel one (embarrassing!)
- Added Documentation/networking/tcp_ao.rst that describes:
  uAPI, has FAQ on RFC 5925 and has implementation details of Linux TCP-AO

Version 7: https://lore.kernel.org/all/20230614230947.3954084-1-dima@arista.com/T/#u

Changes from v6:
- Some more trivial build warnings fixups (kernel test robot <lkp@intel.com>)
- Added TCP_AO_REPAIR setsockopt(), getsockopt()
- Allowed TCP_AO_* setsockopts if (tp->repair) is on
- Added selftests for TCP_AO_REPAIR, that also check incorrect
  ISNs/SNEs, which result in a broken TCP-AO connection - that verifies
  that both Initial Sequence Numbers and Sequence Number Extension are
  part of MAC generation
- Using TCP_AO_REPAIR added a selftest for SEQ numbers rollover,
  checking that SNE was incremented, connection is alive post-rolloever
  and no TCP segments with a wrong signature arrived
- Wrote a selftest for RST segments: both active reset (goes through
  transmit_skb()) and passive reset (goes through tcp_v{4,6}_send_reset()).
- Refactored and made readable tcp_v{4,6}_send_reset(), also adding
  support for TCP_LISTEN/TCP_NEW_SYN_RECV
- Dropped per-CPU ahash requests allocations in favor of Herbert's
  clone-tfm crypto API
- Added Donald Cassidy to Cc as he's interested in getting it into RHEL.

Version 6: https://lore.kernel.org/all/20230512202311.2845526-1-dima@arista.com/T/#u

iperf[3] benchmarks for version 6:
                           v6.4-rc1                 TCP-AO-v6
  TCP                      43.9 Gbits/sec           43.5 Gbits/sec
  TCP-MD5                  2.20 Gbits/sec           2.25 Gbits/sec
  TCP-AO(hmac(sha1))                                2.53 Gbits/sec
  TCP-AO(hmac(sha512))                              1.67 Gbits/sec
  TCP-AO(hmac(sha384))                              1.77 Gbits/sec
  TCP-AO(hmac(sha224))                              1.29 Gbits/sec
  TCP-AO(hmac(sha3-512))                             481 Mbits/sec
  TCP-AO(hmac(md5))                                 2.07 Gbits/sec
  TCP-AO(hmac(rmd160))                              1.01 Gbits/sec
  TCP-AO(cmac(aes128))                              2.11 Gbits/sec

Changes from v5:
- removed check for TCP_AO_KEYF_IFINDEX in delete command:
  VRF might have been destroyed, there still needs to be a way to delete
  keys that were bound to that l3intf (should tcp_v{4,6}_parse_md5_keys()
  avoid the same check as well?)
- corrected copy'n'paste typo in tcp_ao_info_cmd() (assign ao_info->rnext_key)
- simplified a bit tcp_ao_copy_mkts_to_user(); added more UAPI checks
  for getsockopt(TCP_AO_GET_KEYS)
- More UAPI selftests in setsockopt-closed: 29 => 120
- ported TCP-AO patches on Herbert's clone-tfm changes
- adjusted iperf patch for TCP-AO UAPI changes from version 5
- added measures for TCP-AO with tcp_sigpool & clone_tfm backends

Version 5: https://lore.kernel.org/all/20230403213420.1576559-1-dima@arista.com/T/#u

Changes from v4:
- Renamed tcp_ao_matched_key() => tcp_ao_established_key()
- Missed `static` in function definitions
  (kernel test robot <lkp@intel.com>)
- Fixed CONFIG_IPV6=m build
- Unexported tcp_md5_*_sigpool() functions
- Cleaned up tcp_ao.h: undeclared tcp_ao_cache_traffic_keys(),
  tcp_v4_ao_calc_key_skb(); removed tcp_v4_inbound_ao_hash()
- Marked "net/tcp: Prepare tcp_md5sig_pool for TCP-AO" as a [draft] patch
- getsockopt() now returns TCP-AO per-key counters
- Another getsockopt() now returns per-ao_info stats: counters
  and accept_icmps flag state
- Wired up getsockopt() returning counters to selftests
- Fixed a porting mistake: TCP-AO hash in some cases was written in TCP
  header without accounting for MAC length of the key, rewritting skb
  shared info
- Fail adding a key with L3 ifindex when !TCP_AO_KEYF_IFINDEX, instead
  of ignoring tcpa_ifindex (stricter UAPI check)
- Added more test-cases to setsockopt-closed.c selftest
- tcp_ao_hash_skb_data() was a copy'n'paste of tcp_md5_hash_skb_data()
  share it now under tcp_sigpool_hash_skb_data()
- tcp_ao_mkt_overlap_v{4,6}() deleted as they just re-invented
  tcp_ao_do_lookup(). That fixes an issue with multiple IPv4-mapped-IPv6
  keys for different peers on a listening socket.
- getsockopt() now is tested to return correct VRF number for a key
- TCP-AO and TCP-MD5 interraction in non/default VRFs: added +19 selftests
  made them SKIP when CONFIG_VRF=n
- unsigned-md5 selftests now checks both scenarios:
  (1) adding TCP-AO key _after_ TCP-MD5 key
  (2) adding TCP-MD5 key _after_ TCP-AO key
- Added a ratelimited warning if TCP-AO key.ifindex doesn't match
  sk->sk_bound_dev_if - that will warn a user for potential VRF issues
- tcp_v{4,6}_parse_md5_keys() now allows adding TCP-MD5 key with
  ifindex=0 and TCP_MD5SIG_FLAG_IFINDEX together with TCP-AO key from
  another VRF
- Add TCP_AO_CMDF_AO_REQUIRED, which makes a socket TCP-AO only,
  rejecting TCP-MD5 keys or any unsigned TCP segments
- Remove `tcpa_' prefix for UAPI structure members
- UAPI cleanup: I've separated & renamed per-socket settings
  (such as ao_info flags + current/rnext set) from per-key changes:
  TCP_AO     => TCP_AO_ADD_KEY
  TCP_AO_DEL => TCP_AO_DEL_KEY
  TCP_AO_GET => TCP_AO_GET_KEYS
  TCP_AO_MOD => TCP_AO_INFO, the structure is now valid for both
                getsockopt() and setsockopt().
- tcp_ao_current_rnext() was split up in order to fail earlier when
  sndid/rcvid specified can't be set, before anything was changed in ao_info
- fetch current_key before dumping TCP-AO keys in getsockopt(TCP_AO_GET_KEYS):
  it may race with changing current_key by RX, which in result might
  produce a dump with no current_key for userspace.
- instead of TCP_AO_CMDF_* flags, used bitfileds: the flags weren't
  shared between all TCP_AO_{ADD,GET,DEL}_KEY{,S}, so bitfields are more
  descriptive here
- use READ_ONCE()/WRITE_ONCE() for current_key and rnext_key more
  consistently; document in comment the rules for accessing them
- selftests: check all setsockopts()/getsockopts() support extending
  option structs

Version 4: https://lore.kernel.org/all/20230215183335.800122-1-dima@arista.com/T/#u

Changes from v3:
- TCP_MD5 dynamic static key enable/disable patches merged separately [4]
- crypto_pool patches were nacked [5], so instead this patch set extends
  TCP-MD5-sigpool to be used for TCP-AO as well as for TCP-MD5
- Added missing `static' for tcp_v6_ao_calc_key()
  (kernel test robot <lkp@intel.com>)
- Removed CONFIG_TCP_AO default=y and added "If unsure, say N."
- Don't leak ao_info and don't create an unsigned TCP socket if there was
  a TCP-AO key during handshake, but it was removed from listening socket
  while the connection was being established
- Migrate to use static_key_fast_inc_not_disabled() and check return
  code of static_branch_inc()
- Change some return codes to EAFNOSUPPORT for error-pathes where
  family is neither AF_INET nor AF_INET6
- setsockopt()s on a closed/listen socket might have created stray ao_info,
  remove it if connect() is called with a correct TCP-MD5 key, the same
  for the reverse situation: remove md5sig_info straight away from the
  socket if it's going to be TCP-AO connection
- IPv4-mapped-IPv6 addresses + selftest in fcnal-test.sh (by Salam)
- fix using uninitialized sisn/disn from stack - it would only make
  non-SYN packets fail verification on a listen socket, which are not
  expected anyway (kernel test robot <lkp@intel.com>)
- implicit padding in UAPI TCP-AO structures converted to explicit
  (spotted-by David Laight)
- Some selftests missed zero-initializers for uapi structs on stack
- Removed tcp_ao_do_lookup_rcvid() and tcp_ao_do_lookup_sndid() in
  favor of unified tcp_ao_matched_key()
- Disallowed setting current/rnext keys on listen sockets - that wasn't
  supported and didn't affect anything, cleanup for the UAPI
- VRFs support for TCP-AO

Version 3: https://lore.kernel.org/all/20221027204347.529913-1-dima@arista.com/T/#u

Changes from v2:
- Added more missing `static' declarations for local functions
  (kernel test robot <lkp@intel.com>)
- Building now with CONFIG_TCP_AO=n and CONFIG_TCP_MD5SIG=n
  (kernel test robot <lkp@intel.com>)
- Now setsockopt(TCP_AO) is allowed when it's TCP_LISTEN or TCP_CLOSE
  state OR the key added is not the first key on a socket (by Salam)
- CONFIG_TCP_AO does not depend on CONFIG_TCP_MD5SIG anymore
- Don't leak tcp_md5_needed static branch counter when TCP-MD5 key
  is modified/changed
- TCP-AO lookups are dynamically enabled/disabled with static key when
  there is ao_info in the system (and when it is destroyed)
- Wired SYN cookies up to TCP-AO (by Salam)
- Fix verification for possible re-transmitted SYN packets (by Salam)
- use sockopt_lock_sock() instead of lock_sock()
  (from v6.1 rebase, commit d51bbff2aba7)
- use sockptr_t in getsockopt(TCP_AO_GET)
  (from v6.1 rebase, commit 34704ef024ae)
- Fixed reallocating crypto_pool's scratch area by IPI while
  crypto_pool_get() was get by another CPU
- selftests on older kernels (or with CONFIG_TCP_AO=n) should exit with
  SKIP, not FAIL (Shuah Khan <shuah@kernel.org>)
- selftests that check interaction between TCP-AO and TCP-MD5 now
  SKIP when CONFIG_TCP_MD5SIG=n
- Measured the performance of different hashing algorithms for TCP-AO
  and compare with TCP-MD5 performance. This is done with hacky patches
  to iperf (see [3]). At this moment I've done it in qemu/KVM with CPU
  affinities set on Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz.
  No performance degradation was noticed before/after patches, but given
  the measures were done in a VM, without measuring it on a physical dut
  it only gives a hint of relative speed for different hash algorithms
  with TCP-AO. Here are results, averaging on 30 measures each:
  TCP:                    3.51Gbits/sec
  TCP-MD5:                1.12Gbits/sec
  TCP-AO(HMAC(SHA1)):     1.53Gbits/sec
  TCP-AO(CMAC(AES128)):   621Mbits/sec
  TCP-AO(HMAC(SHA512)):   1.21Gbits/sec
  TCP-AO(HMAC(SHA384)):   1.20Gbits/sec
  TCP-AO(HMAC(SHA224)):   961Mbits/sec
  TCP-AO(HMAC(SHA3-512)): 157Mbits/sec
  TCP-AO(HMAC(RMD160)):   659Mbits/sec
  TCP-AO(HMAC(MD5):       1.12Gbits/sec
  (the last one is just for fun, but may make sense as it provides
  the same security as TCP-MD5, but allows multiple keys and a mechanism
  to change them from RFC5925)

Version 2: https://lore.kernel.org/all/20220923201319.493208-1-dima@arista.com/T/#u

Changes from v1:
- Building now with CONFIG_IPV6=n (kernel test robot <lkp@intel.com>)
- Added missing static declarations for local functions
  (kernel test robot <lkp@intel.com>)
- Addressed static analyzer and review comments by Dan Carpenter
  (thanks, they were very useful!)
- Fix elif without defined() for !CONFIG_TCP_AO
- Recursively build selftests/net/tcp_ao (Shuah Khan), patches in:
  https://lore.kernel.org/all/20220919201958.279545-1-dima@arista.com/T/#u
- Don't leak crypto_pool reference when TCP-MD5 key is modified/changed
- Add TCP-AO support for nettest.c and fcnal-test.sh
  (will be used for VRF testing in later versions)

Comparison between Leonard proposal and this (overview):
https://lore.kernel.org/all/3cf03d51-74db-675c-b392-e4647fa5b5a6@arista.com/T/#u

Version 1: https://lore.kernel.org/all/20220818170005.747015-1-dima@arista.com/T/#u

This patchset implements the TCP-AO option as described in RFC5925. There
is a request from industry to move away from TCP-MD5SIG and it seems the time
is right to have a TCP-AO upstreamed. This TCP option is meant to replace
the TCP MD5 option and address its shortcomings. Specifically, it provides
more secure hashing, key rotation and support for long-lived connections
(see the summary of TCP-AO advantages over TCP-MD5 in (1.3) of RFC5925).
The patch series starts with six patches that are not specific to TCP-AO
but implement a general crypto facility that we thought is useful
to eliminate code duplication between TCP-MD5SIG and TCP-AO as well as other
crypto users. These six patches are being submitted separately in
a different patchset [1]. Including them here will show better the gain
in code sharing. Next are 18 patches that implement the actual TCP-AO option,
followed by patches implementing selftests.

The patch set was written as a collaboration of three authors (in alphabetical
order): Dmitry Safonov, Francesco Ruggeri and Salam Noureddine. Additional
credits should be given to Prasad Koya, who was involved in early prototyping
a few years back. There is also a separate submission done by Leonard Crestez
whom we thank for his efforts getting an implementation of RFC5925 submitted
for review upstream [2]. This is an independent implementation that makes
different design decisions.

For example, we chose a similar design to the TCP-MD5SIG implementation and
used setsockopts to program per-socket keys, avoiding the extra complexity
of managing a centralized key database in the kernel. A centralized database
in the kernel has dubious benefits since it doesn’t eliminate per-socket
setsockopts needed to specify which sockets need TCP-AO and what are the
currently preferred keys. It also complicates traffic key caching and
preventing deletion of in-use keys.

In this implementation, a centralized database of keys can be thought of
as living in user space and user applications would have to program those
keys on matching sockets. On the server side, the user application programs
keys (MKTS in TCP-AO nomenclature) on the listening socket for all peers that
are expected to connect. Prefix matching on the peer address is supported.
When a peer issues a successful connect, all the MKTs matching the IP address
of the peer are copied to the newly created socket. On the active side,
when a connect() is issued all MKTs that do not match the peer are deleted
from the socket since they will never match the peer. This implementation
uses three setsockopt()s for adding, deleting and modifying keys on a socket.
All three setsockopt()s have extensive sanity checks that prevent
inconsistencies in the keys on a given socket. A getsockopt() is provided
to get key information from any given socket.

Few things to note about this implementation:
- Traffic keys are cached for established connections avoiding the cost of
  such calculation for each packet received or sent.
- Great care has been taken to avoid deleting in-use MKTs
  as required by the RFC.
- Any crypto algorithm supported by the Linux kernel can be used
  to calculate packet hashes.
- Fastopen works with TCP-AO but hasn’t been tested extensively.
- Tested for interop with other major networking vendors (on linux-4.19),
  including testing for key rotation and long lived connections.

[1]: https://lore.kernel.org/all/20220726201600.1715505-1-dima@arista.com/
[2]: https://lore.kernel.org/all/cover.1658815925.git.cdleonard@gmail.com/
[3]: https://github.com/0x7f454c46/iperf/tree/tcp-md5-ao
[4]: https://lore.kernel.org/all/166995421700.16716.17446147162780881407.git-patchwork-notify@kernel.org/T/#u
[5]: https://lore.kernel.org/all/Y8kSkW4X4vQdFyOl@gondor.apana.org.au/T/#u
[6]: https://lore.kernel.org/all/ZDefxOq6Ax0JeTRH@gondor.apana.org.au/T/#u

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: David Laight <David.Laight@aculab.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Donald Cassidy <dcassidy@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
Cc: Gaillardetz, Dominik <dgaillar@ciena.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Ivan Delalande <colona@arista.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Leonard Crestez <cdleonard@gmail.com>
Cc: Nassiri, Mohammad <mnassiri@ciena.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: Simon Horman <simon.horman@corigine.com>
Cc: Tetreault, Francois <ftetreau@ciena.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Dmitry Safonov (23):
  net/tcp: Prepare tcp_md5sig_pool for TCP-AO
  net/tcp: Add TCP-AO config and structures
  net/tcp: Introduce TCP_AO setsockopt()s
  net/tcp: Prevent TCP-MD5 with TCP-AO being set
  net/tcp: Calculate TCP-AO traffic keys
  net/tcp: Add TCP-AO sign to outgoing packets
  net/tcp: Add tcp_parse_auth_options()
  net/tcp: Add AO sign to RST packets
  net/tcp: Add TCP-AO sign to twsk
  net/tcp: Wire TCP-AO to request sockets
  net/tcp: Sign SYN-ACK segments with TCP-AO
  net/tcp: Verify inbound TCP-AO signed segments
  net/tcp: Add TCP-AO segments counters
  net/tcp: Add TCP-AO SNE support
  net/tcp: Add tcp_hash_fail() ratelimited logs
  net/tcp: Ignore specific ICMPs for TCP-AO connections
  net/tcp: Add option for TCP-AO to (not) hash header
  net/tcp: Add TCP-AO getsockopt()s
  net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
  net/tcp: Add static_key for TCP-AO
  net/tcp: Wire up l3index to TCP-AO
  net/tcp: Add TCP_AO_REPAIR
  Documentation/tcp: Add TCP-AO documentation

 Documentation/networking/index.rst  |    1 +
 Documentation/networking/tcp_ao.rst |  434 +++++
 include/linux/sockptr.h             |   23 +
 include/linux/tcp.h                 |   30 +-
 include/net/dropreason-core.h       |   30 +
 include/net/tcp.h                   |  218 ++-
 include/net/tcp_ao.h                |  347 ++++
 include/uapi/linux/snmp.h           |    5 +
 include/uapi/linux/tcp.h            |  105 ++
 net/ipv4/Kconfig                    |   17 +
 net/ipv4/Makefile                   |    2 +
 net/ipv4/proc.c                     |    5 +
 net/ipv4/syncookies.c               |    4 +
 net/ipv4/tcp.c                      |  246 +--
 net/ipv4/tcp_ao.c                   | 2341 +++++++++++++++++++++++++++
 net/ipv4/tcp_input.c                |   97 +-
 net/ipv4/tcp_ipv4.c                 |  334 +++-
 net/ipv4/tcp_minisocks.c            |   50 +-
 net/ipv4/tcp_output.c               |  232 ++-
 net/ipv4/tcp_sigpool.c              |  358 ++++
 net/ipv6/Makefile                   |    1 +
 net/ipv6/syncookies.c               |    5 +
 net/ipv6/tcp_ao.c                   |  168 ++
 net/ipv6/tcp_ipv6.c                 |  342 +++-
 24 files changed, 5022 insertions(+), 373 deletions(-)
 create mode 100644 Documentation/networking/tcp_ao.rst
 create mode 100644 include/net/tcp_ao.h
 create mode 100644 net/ipv4/tcp_ao.c
 create mode 100644 net/ipv4/tcp_sigpool.c
 create mode 100644 net/ipv6/tcp_ao.c


base-commit: 73be7fb14e83d24383f840a22f24d3ed222ca319
-- 
2.41.0

