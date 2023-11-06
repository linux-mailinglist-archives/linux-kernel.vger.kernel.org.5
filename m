Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F47E29A6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjKFQZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjKFQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:25:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7881BF;
        Mon,  6 Nov 2023 08:25:45 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A21FD20068;
        Mon,  6 Nov 2023 16:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1699287943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ob/3KR5vtw053vP6IAp0IYpjgIdHRPjmD1sNZvpeql0=;
        b=mi0IHoKw5riU85/0sf6qaNa3jS2PNV4ug2EA+CCnutY6KPZQV6dTb4Xksq75570q8Jb3km
        oxDxxEH7yiTDcwFQt4c6qkcrhFxh9jRMOEz4T092ogvEyOOMCYUtBGt0w1ksnA+fLL8yL9
        ix+xQ+OksjB5ZSJA/1WIB/EmhA/n8sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1699287943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ob/3KR5vtw053vP6IAp0IYpjgIdHRPjmD1sNZvpeql0=;
        b=sFVp2uUDhufFOXyNbCdYdXLvAFvLiW31KQPhmoQrNMoola6hV9DCxWebYU0kYU09tqI4zL
        ErLs8L3wmQp4RnDA==
Received: from localhost.cz (lhruska.udp.ovpn2.prg.suse.de [10.100.204.118])
        by relay2.suse.de (Postfix) with ESMTP id 3CB9A2CD83;
        Mon,  6 Nov 2023 16:25:43 +0000 (UTC)
From:   Lukas Hruska <lhruska@suse.cz>
To:     Petr Mladek <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        Lukas Hruska <lhruska@suse.cz>
Subject: [PATCH v1 0/5] livepatch: klp-convert tool - Minimal version
Date:   Mon,  6 Nov 2023 17:25:08 +0100
Message-ID: <20231106162513.17556-1-lhruska@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary
-------

This is a significantly simplified version of the original klp-convert tool.
The klp-convert code has never got a proper review and also clean ups 
were not easy. The last version was v7, see 
https://lore.kernel.org/r/20230306140824.3858543-1-joe.lawrence@redhat.com

The main change is that the tool does not longer search for the 
symbols which would need the livepatch specific relocation entry.
Also klp.symbols file is not longer needed.

Instead, the needed information is appended to the symbol declaration
via a new macro KLP_RELOC_SYMBOL(). It creates symbol with all needed
metadata. For example:

  extern char *saved_command_line \
                 KLP_RELOC_SYMBOL(vmlinux, vmlinux, saved_command_line, 0); 

would create symbol

$>readelf -r -W <compiled livepatch module>:
Relocation section '.rela.text' at offset 0x32e60 contains 10 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
[...]
0000000000000068  0000003c00000002 R_X86_64_PC32          0000000000000000 .klp.sym.rela.vmlinux.vmlinux.saved_command_line,0 - 4 
[...]


The simplified klp-convert tool just transforms symbols
created by KLP_RELOC_SYMBOL() to object specific rela sections
and rela entries which would later be proceed when the livepatch
or the livepatched object is loaded.

For example, klp-convert would replace the above symbols with:

$> readelf -r -W <livepatch_module_proceed_by_klp_convert>
Relocation section '.klp.rela.vmlinux.text' at offset 0x5cb60 contains 1 entry:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000068  0000003c00000002 R_X86_64_PC32          0000000000000000 .klp.sym.vmlinux.saved_command_line,0 - 4 


Note that similar macro was needed also in the original version
to handle more symbols of the same name (sympos).

Given the above, add klp-convert tool; integrate klp-convert tool into
kbuild; add data-structure and macros to enable users to annotate
livepatch source code; make modpost stage compatible with livepatches;
update livepatch-sample and update documentation.


Testing
-------

The patchset selftests build and execute on x86_64, s390x, and ppc64le
for both default config (with added livepatch dependencies) and a larger
SLE-15-ish config.


Summary of changes in this minimal version
------------------------

- rebase for v6.5
- cleaned-up SoB chains (suggested by pmladek)
- klp-convert: remove the symbol map auto-resolving solution
- klp-convert: add macro for flagging variables inside a LP src to be resolved by this tool
- klp-convert: code simplification

Previous versions
-----------------

RFC:
  https://lore.kernel.org/lkml/cover.1477578530.git.jpoimboe@redhat.com/
v2:
  https://lore.kernel.org/lkml/f52d29f7-7d1b-ad3d-050b-a9fa8878faf2@redhat.com/
v3:
  https://lore.kernel.org/lkml/20190410155058.9437-1-joe.lawrence@redhat.com/
v4:
  https://lore.kernel.org/lkml/20190509143859.9050-1-joe.lawrence@redhat.com/
v5:
  (not posted)
  https://github.com/joe-lawrence/klp-convert-tree/tree/klp-convert-v5-devel
v6:
  https://lore.kernel.org/live-patching/20220216163940.228309-1-joe.lawrence@redhat.com/
v7:
  https://lore.kernel.org/all/20230306140824.3858543-1-joe.lawrence@redhat.com/

