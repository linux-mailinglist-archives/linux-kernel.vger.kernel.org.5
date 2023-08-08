Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C256774303
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHHRzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHHRyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:54:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846BC2945A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:24:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92F0320315;
        Tue,  8 Aug 2023 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691486154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Qnuw4NSvn2AmhK06974lvXqwW3/Fg/EvxHvoLZgamm0=;
        b=g6i559iBH9MrSdxsx+7dOMGeY+vjhzEajYfhYUYJR0KUPgg6dNMPEl9S1hDp0P53s19uZv
        9uRD0wtn1SkmVvYkTf/DIXy9j2ODF8+08nxFRm5yN8nEFqQ9H6x1+HCBuJBC9RTOgLA9WD
        BRQaKv4+VHLk7iD0n6gpNAzWbZSnGWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691486154;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Qnuw4NSvn2AmhK06974lvXqwW3/Fg/EvxHvoLZgamm0=;
        b=owksqn4iATOVSM18f+6OO5xQrSJ/30YxSMbLOEn0XX7gBrNwS8E+8yR0p1IYwn1uvDOXke
        9xgimDGGv+6YteDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8640613451;
        Tue,  8 Aug 2023 09:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sSuoIMoH0mQ/EwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 09:15:54 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Caleb Sander <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v3 0/2] Do not pass disable_sqflow if not supported
Date:   Tue,  8 Aug 2023 11:15:48 +0200
Message-ID: <20230808091550.25349-1-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow up on the discussion in [1]

[1] https://lore.kernel.org/linux-nvme/676b7c2b-7bcf-6138-0229-389ed9efaa92@grimberg.me/

changes:
v3:
  - do not even try to use disable_sqflow if when it not supported
v2:
  - use cached options table
v1
  - initial verison

Sagi Grimberg (2):
  fabrics: Read the supported options lazy
  fabrics: Do not pass disable_sqflow if not supported

 src/nvme/fabrics.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.41.0

