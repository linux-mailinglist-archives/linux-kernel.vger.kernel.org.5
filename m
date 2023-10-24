Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1820A7D4EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjJXLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJXLRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:17:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D5FE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698146247;
        bh=YtEPfVNWasWImZJIQeh70OjS+3z95AdF8BbO4YBvGL8=;
        h=From:To:Cc:Subject:Date:From;
        b=gPkplYqQJvMlVgxNmd3FMHKjMxawBfRqNT6kO+SeM40vQf7CPQhLcmfE5Js55bpeO
         yPavOktkxw4o7eSuSqu5DK5gKNEqhgy2MCNNb6rajOh7xkngkG7Mn/umAGdHaY+TG4
         1DMbVdetjAwlAyZ6sFJTDrpkbO5escGNHx414yuyAIbGIRiHDAlBUPpjmt5H3xuU3j
         Jkbl/Mzgqi3jJzarmAs2/F3RbI4xrpzv80Z7S6w/drJMbVNEJjQuDlQphJpzrcS/TX
         Z1QmH/rF4qYwBxyzDVik0cuwEthit+SYwm/W2gOSRjDuzhgDjgb411MHOcEw9U4tFn
         yEsHVj+pFZ6oA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SF8fb3zrCz4x3D;
        Tue, 24 Oct 2023 22:17:27 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <akpm@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Subject: [PATCH] checkpatch: Recognise "Debugged-by" tags
Date:   Tue, 24 Oct 2023 22:17:14 +1100
Message-ID: <20231024111714.1814510-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checkpatch complains about "Debugged-by:" tags:

  WARNING: Non-standard signature: Debugged-by:
  #33:
  Debugged-by: Jane Doe <jane@doe.com>

There are over 150 Debugged-by tags already in the history, so
checkpatch should allow them.

Additionally checkpatch will now catch small typos, eg:

  WARNING: Non-standard signature: 'Debuged-by:' - perhaps 'Debugged-by:'?
  #17:
    Debuged-by: Jane Doe <jane@doe.com>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..31774351bae1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -618,6 +618,7 @@ our $signature_tags = qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Debugged-by:|
 	To:|
 	Cc:
 )};
@@ -711,7 +712,7 @@ sub find_standard_signature {
 	my ($sign_off) = @_;
 	my @standard_signature_tags = (
 		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
-		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'
+		'Reviewed-by:', 'Reported-by:', 'Suggested-by:', 'Debugged-by:'
 	);
 	foreach my $signature (@standard_signature_tags) {
 		return $signature if (get_edit_distance($sign_off, $signature) <= 2);
-- 
2.41.0

