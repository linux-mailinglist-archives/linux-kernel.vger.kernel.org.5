Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935577681FB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 23:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjG2VmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 17:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG2VmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 17:42:01 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54310FF
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 14:42:00 -0700 (PDT)
Date:   Sat, 29 Jul 2023 21:41:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1690666916; x=1690926116;
        bh=ayP6Lyd6vT/OxN20N2dQ1W7dWvfMQN5QQ+y6w2FEL6Q=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=G60o1xdPn+JjOOgIzmI861dk2YeVZJ39YNneJhBKhlRLWSzwZgCKj9wgED7B0RKMA
         z1OxEZW+259UrII6jmqU7DG1xbnjdpl90TFCKkOEfluj2IzBDi8W+9jCqQnezkhNYt
         F9TCQHKjDpkQqU/2fj/e9t2Fh9uEuRJLI4MJVy0R23N2ZTWEDrk2WxgRjlEIab9H5/
         Dnv9lNP7L8wPYpKmTg3QsDLyvNHTEKw78suejQklUbY/aMi3plT824ZAdui9A8HWYl
         KzDVr3RzDGFY6f01jhCmtY1iYITdVZojIt0BBz/0Ls56/nD2LE1XYFfEpr8jcpamL4
         RAcyE3JxhJFvA==
To:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Rahul Rameshbabu <sergeantsagara@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] scripts: merge_config: Add flag to prevent unsetting config option
Message-ID: <20230729214138.79902-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overriding a previously defined entry for a config option with 'is not set'
may be undesirable in some fragment configuration setups. Provide a flag to
change the behavior, so 'is not set' is not overridden when a previous
value for the same config option already exists.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---
 scripts/kconfig/merge_config.sh | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config=
.sh
index 902eb429b9db..bbe235f2df70 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -30,6 +30,7 @@ usage() {
 =09echo "  -O    dir to put generated output files.  Consider setting \$KC=
ONFIG_CONFIG instead."
 =09echo "  -s    strict mode. Fail if the fragment redefines any value."
 =09echo "  -Q    disable warning messages for overridden options."
+=09echo "  -N    not set entries in fragments will not override options."
 =09echo
 =09echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_=
 environment variable."
 }
@@ -42,6 +43,7 @@ OUTPUT=3D.
 STRICT=3Dfalse
 CONFIG_PREFIX=3D${CONFIG_-CONFIG_}
 WARNOVERRIDE=3Decho
+OVERRIDENOTSET=3Dtrue
=20
 while true; do
 =09case $1 in
@@ -89,6 +91,11 @@ while true; do
 =09=09shift
 =09=09continue
 =09=09;;
+=09"-N")
+=09=09OVERRIDENOTSET=3Dfalse
+=09=09shift
+=09=09continue
+=09=09;;
 =09*)
 =09=09break
 =09=09;;
@@ -143,13 +150,20 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
 =09=09grep -q -w $CFG $TMP_FILE || continue
 =09=09PREV_VAL=3D$(grep -w $CFG $TMP_FILE)
 =09=09NEW_VAL=3D$(grep -w $CFG $MERGE_FILE)
-=09=09BUILTIN_FLAG=3Dfalse
-=09=09if [ "$BUILTIN" =3D "true" ] && [ "${NEW_VAL#CONFIG_*=3D}" =3D "m" ]=
 && [ "${PREV_VAL#CONFIG_*=3D}" =3D "y" ]; then
+=09=09NO_OVERRIDE_FLAG=3Dfalse
+=09=09if [ "$OVERRIDENOTSET" =3D "false" ] && [ "${NEW_VAL#\# CONFIG_* }" =
=3D "is not set" ] &&
+=09=09=09   [ "$PREV_VAL" !=3D "" ] && [ "${PREV_VAL#\# CONFIG_* }" !=3D "=
is not set" ]; then
+=09=09=09${WARNOVERRIDE} Previous  value: $PREV_VAL
+=09=09=09${WARNOVERRIDE} New value:       $NEW_VAL
+=09=09=09${WARNOVERRIDE} -N passed, will not unset option
+=09=09=09${WARNOVERRIDE}
+=09=09=09NO_OVERRIDE_FLAG=3Dtrue
+=09=09elif [ "$BUILTIN" =3D "true" ] && [ "${NEW_VAL#CONFIG_*=3D}" =3D "m"=
 ] && [ "${PREV_VAL#CONFIG_*=3D}" =3D "y" ]; then
 =09=09=09${WARNOVERRIDE} Previous  value: $PREV_VAL
 =09=09=09${WARNOVERRIDE} New value:       $NEW_VAL
 =09=09=09${WARNOVERRIDE} -y passed, will not demote y to m
 =09=09=09${WARNOVERRIDE}
-=09=09=09BUILTIN_FLAG=3Dtrue
+=09=09=09NO_OVERRIDE_FLAG=3Dtrue
 =09=09elif [ "x$PREV_VAL" !=3D "x$NEW_VAL" ] ; then
 =09=09=09${WARNOVERRIDE} Value of $CFG is redefined by fragment $ORIG_MERG=
E_FILE:
 =09=09=09${WARNOVERRIDE} Previous  value: $PREV_VAL
@@ -161,7 +175,7 @@ for ORIG_MERGE_FILE in $MERGE_LIST ; do
 =09=09elif [ "$WARNREDUN" =3D "true" ]; then
 =09=09=09${WARNOVERRIDE} Value of $CFG is redundant by fragment $ORIG_MERG=
E_FILE:
 =09=09fi
-=09=09if [ "$BUILTIN_FLAG" =3D "false" ]; then
+=09=09if [ "$NO_OVERRIDE_FLAG" =3D "false" ]; then
 =09=09=09sed -i "/$CFG[ =3D]/d" $TMP_FILE
 =09=09else
 =09=09=09sed -i "/$CFG[ =3D]/d" $MERGE_FILE
--=20
2.40.1


