Return-Path: <linux-kernel+bounces-166387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118F18B99F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B061C21CD1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C16629E6;
	Thu,  2 May 2024 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuZziewm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FC760DE9
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649048; cv=none; b=OWWsAF6VwmNTsr7eOypgyUjG4ybf+s7v8gICv0lUFbVCQNmfFOsanCjXcmQbUZa3KY/EbbFPjvS7mWellmLKZDlKroRlfaBGQuL8ngzdXju+KDSkttTlPtu8WPkItEvxo90Ur6vLsMDP3tRt2vcfhafC8ZtCHtnrEejIq+jcMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649048; c=relaxed/simple;
	bh=3BsYr5GY8+DN1Cqhi1SWPVOenkTI4gCJ/13mNvl0t5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=THXWgG95AXgL7m/E12xQ4D7H6N9Y16DeO2VjyOwJqoj3dqwplXjHtQs2Jbpcy3lQ43D1AbCkshzbiTahdBNAwH1dLZIDa2JnHtRCx39X2HmXbjchzUK6AfTqoX1jg1K7xCfsNcpcD9YQJgWSEhsTdYS4ZPif7bGWiKbBh8egc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FuZziewm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714649045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Av/id9hmBlLg4KcvyaywN2IiF2o6K3QcgBvIFp2NqD8=;
	b=FuZziewmdxF/zO4wA6URLuoJZtmBpCagq4qO4bhCE876Ho/pTjwGaSg8QQAUKdSeEKEqfk
	i4lk/BtQDrsOd4ayTKiqmJGihEBlynIHk6yWovSw3uxrclLTTf4joUAyOl48nxRd+Gme7a
	dCoHAGFLUAbRNC4QJ+TomlKyY4CNcWQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-VMh_fc6bNTerj3KxOP3BNQ-1; Thu,
 02 May 2024 07:24:02 -0400
X-MC-Unique: VMh_fc6bNTerj3KxOP3BNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1B24299E750;
	Thu,  2 May 2024 11:24:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7D0D7202450D;
	Thu,  2 May 2024 11:24:00 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.9-rc7
Date: Thu,  2 May 2024 13:23:26 +0200
Message-ID: <20240502112326.34463-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi Linus!

The following changes since commit 52afb15e9d9a021ab6eec923a087ec9f518cb713:

  Merge tag 'net-6.9-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-04-25 11:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.9-rc7

for you to fetch changes up to 78cfe547607a83de60cd25304fa2422777634712:

  MAINTAINERS: mark MYRICOM MYRI-10G as Orphan (2024-05-02 11:24:03 +0200)

----------------------------------------------------------------
Including fixes from bpf.

Relatively calm week, likely due to public holiday in most places.
No known outstanding regressions.

Current release - regressions:

  - rxrpc: fix wrong alignmask in __page_frag_alloc_align()

  - eth: e1000e: change usleep_range to udelay in PHY mdic access

Previous releases - regressions:

  - gro: fix udp bad offset in socket lookup

  - bpf: fix incorrect runtime stat for arm64

  - tipc: fix UAF in error path

  - netfs: fix a potential infinite loop in extract_user_to_sg()

  - eth: ice: ensure the copied buf is NUL terminated

  - eth: qeth: fix kernel panic after setting hsuid

Previous releases - always broken:

  - bpf:
    - verifier: prevent userspace memory access
    - xdp: use flags field to disambiguate broadcast redirect

  - bridge: fix multicast-to-unicast with fraglist GSO

  - mptcp: ensure snd_nxt is properly initialized on connect

  - nsh: fix outer header access in nsh_gso_segment().

  - eth: bcmgenet: fix racing registers access

  - eth: vxlan: fix stats counters.

Misc:

  - a bunch of MAINTAINERS file updates

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandra Winter (1):
      s390/qeth: Fix kernel panic after setting hsuid

Alexei Starovoitov (1):
      Merge branch 'bpf-prevent-userspace-memory-access'

Andrii Nakryiko (1):
      bpf, kconfig: Fix DEBUG_INFO_BTF_MODULES Kconfig definition

Anton Protopopov (1):
      bpf: Fix a verifier verbose message

Asbjørn Sloth Tønnesen (4):
      net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
      net: qede: use return from qede_parse_flow_attr() for flower
      net: qede: use return from qede_parse_flow_attr() for flow_spec
      net: qede: use return from qede_parse_actions()

Björn Töpel (1):
      MAINTAINERS: bpf: Add Lehui and Puranjay as riscv64 reviewers

Bui Quang Minh (3):
      ice: ensure the copied buf is NUL terminated
      bna: ensure the copied buf is NUL terminated
      octeontx2-af: avoid off-by-one read from userspace

David Bauer (1):
      net l2tp: drop flow hash on forward

David Howells (1):
      Fix a potential infinite loop in extract_user_to_sg()

David S. Miller (3):
      Merge branch 'bcmgenet-protect-contended-accesses'
      Merge branch 'qed-error-codes'
      Merge branch 'vxlan-stats'

Doug Berger (3):
      net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
      net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
      net: bcmgenet: synchronize UMAC_CMD access

Felix Fietkau (2):
      net: bridge: fix multicast-to-unicast with fraglist GSO
      net: core: reject skb_copy(_expand) for fraglist GSO skbs

Guillaume Nault (3):
      vxlan: Fix racy device stats updates.
      vxlan: Add missing VNI filter counter update in arp_reduce().
      vxlan: Pull inner IP header in vxlan_rcv().

Jakub Kicinski (5):
      Merge branch 'ensure-the-copied-buf-is-nul-terminated'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      MAINTAINERS: add an explicit entry for YNL
      MAINTAINERS: remove Ariel Elior
      MAINTAINERS: mark MYRICOM MYRI-10G as Orphan

Jason Xing (1):
      bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue

Jeffrey Altman (1):
      rxrpc: Clients must accept conn from any address

Kuniyuki Iwashima (1):
      nsh: Restore skb->{protocol,data,mac_header} for outer header in nsh_gso_segment().

Marek Behún (1):
      net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341

Paolo Abeni (3):
      mptcp: ensure snd_nxt is properly initialized on connect
      tipc: fix UAF in error path
      Merge branch 'net-gro-add-flush-flush_id-checks-and-fix-wrong-offset-in-udp'

Puranjay Mohan (5):
      MAINTAINERS: Update email address for Puranjay Mohan
      arm32, bpf: Reimplement sign-extension mov instruction
      bpf: verifier: prevent userspace memory access
      bpf, x86: Fix PROBE_MEM runtime load check
      selftests/bpf: Test PROBE_MEM of VSYSCALL_ADDR on x86-64

Richard Gobert (2):
      net: gro: fix udp bad offset in socket lookup by adding {inner_}network_offset to napi_gro_cb
      net: gro: add flush check in udp_gro_receive_segment

Sebastian Andrzej Siewior (1):
      cxgb4: Properly lock TX queue for the selftest.

Shigeru Yoshida (1):
      ipv4: Fix uninit-value access in __ip_make_skb()

Toke Høiland-Jørgensen (1):
      xdp: use flags field to disambiguate broadcast redirect

Vitaly Lifshits (1):
      e1000e: change usleep_range to udelay in PHY mdic access

Xin Long (1):
      tipc: fix a possible memleak in tipc_buf_append

Xu Kuohai (2):
      bpf, arm64: Fix incorrect runtime stats
      riscv, bpf: Fix incorrect runtime stats

Yunsheng Lin (1):
      rxrpc: Fix using alignmask being zero for __page_frag_alloc_align()

 .mailmap                                           |  1 +
 MAINTAINERS                                        | 22 +++++---
 arch/arm/net/bpf_jit_32.c                          | 56 ++++++++++++++-----
 arch/arm64/net/bpf_jit_comp.c                      |  6 +--
 arch/riscv/net/bpf_jit_comp64.c                    |  6 +--
 arch/x86/net/bpf_jit_comp.c                        | 63 +++++++++++-----------
 drivers/net/dsa/mv88e6xxx/chip.c                   |  4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 16 +++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  4 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  8 ++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |  6 ++-
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c    |  4 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |  6 +--
 drivers/net/ethernet/intel/e1000e/phy.c            |  8 +--
 drivers/net/ethernet/intel/ice/ice_debugfs.c       |  8 +--
 .../ethernet/marvell/octeontx2/af/rvu_debugfs.c    |  4 +-
 drivers/net/ethernet/qlogic/qede/qede_filter.c     | 14 ++---
 drivers/net/vxlan/vxlan_core.c                     | 49 +++++++++++------
 drivers/s390/net/qeth_core_main.c                  | 61 ++++++++++-----------
 include/linux/filter.h                             |  1 +
 include/linux/skmsg.h                              |  2 +
 include/net/gro.h                                  |  9 ++++
 kernel/bpf/core.c                                  |  9 ++++
 kernel/bpf/verifier.c                              | 33 +++++++++++-
 lib/Kconfig.debug                                  |  5 +-
 lib/scatterlist.c                                  |  2 +-
 net/8021q/vlan_core.c                              |  2 +
 net/bridge/br_forward.c                            |  2 +-
 net/core/filter.c                                  | 42 +++++++++++----
 net/core/gro.c                                     |  1 +
 net/core/skbuff.c                                  | 27 +++++++---
 net/core/skmsg.c                                   |  5 +-
 net/ipv4/af_inet.c                                 |  1 +
 net/ipv4/ip_output.c                               |  2 +-
 net/ipv4/raw.c                                     |  3 ++
 net/ipv4/udp.c                                     |  3 +-
 net/ipv4/udp_offload.c                             | 15 +++++-
 net/ipv6/ip6_offload.c                             |  1 +
 net/ipv6/udp.c                                     |  3 +-
 net/ipv6/udp_offload.c                             |  3 +-
 net/l2tp/l2tp_eth.c                                |  3 ++
 net/mptcp/protocol.c                               |  3 ++
 net/nsh/nsh.c                                      | 14 ++---
 net/rxrpc/conn_object.c                            |  9 +---
 net/rxrpc/insecure.c                               |  2 +-
 net/rxrpc/rxkad.c                                  |  2 +-
 net/rxrpc/txbuf.c                                  | 10 ++--
 net/tipc/msg.c                                     |  8 ++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  3 ++
 49 files changed, 378 insertions(+), 193 deletions(-)


