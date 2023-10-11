Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D827C46D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjJKAqQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 20:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbjJKAqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:46:10 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1815FB;
        Tue, 10 Oct 2023 17:46:00 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 55698160303;
        Wed, 11 Oct 2023 00:45:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 0231720026;
        Wed, 11 Oct 2023 00:45:56 +0000 (UTC)
Message-ID: <f19f55f13682a6c019be2a67e4acb07e94e103f3.camel@perches.com>
Subject: Re: [PATCH v3] Documentation/process/coding-style.rst: space around
 const
From:   Joe Perches <joe@perches.com>
To:     Max Kellermann <max.kellermann@ionos.com>, linux@roeck-us.net,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Oct 2023 17:45:55 -0700
In-Reply-To: <20231010125832.1002941-1-max.kellermann@ionos.com>
References: <20231010125832.1002941-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0231720026
X-Stat-Signature: ftb4aswraeg9ufnzdw15mwoboyoeo934
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX181EpPdpemFZmpY9nkwWDJH0zZmsZ2ZaUo=
X-HE-Tag: 1696985156-390945
X-HE-Meta: U2FsdGVkX184/p56Wz98aBmu/bGpEMuwN80kbPn/OzGG3c3XICAqYEdACsIuzDe2ZcHe5izk65H1HKz0dIFU+9BSRd/Xnl6fg8RjVoe+Gng81t6pZob0I15wXzBvD4hAkVAQi5rFcyaPuXzRw+cXqFReXvaNJZoE1X9+u0VQ12qlIFsDcz9jw1nTz3fZndLRI1YaB/04BRFE7NUxb56mmykOq7BrUhoPpRTo134fiJPaovV328+1p0IAPnYJs3MKKDCv+5LALwt7EYQk6hL/+ucadioG/j7W5yW4YWL+LaN8iu47kat1/018I8c8aN5R
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 14:58 +0200, Max Kellermann wrote:
> There are currently no rules on the placement of "const", but a recent
> code submission revealed that there is clearly a preference for spaces
> around it.
> 
> checkpatch.pl has no check at all for this; though it does sometimes
> complain, but only because it erroneously thinks that the "*" (on
> local variables) is an unary dereference operator, not a pointer type.
> 

Maybe something like this for checkpatch:
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda1128..48d70d0ad9a2b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4726,6 +4726,16 @@ sub process {
 			}
 		}
 
+# check for const* and *const uses that should have space around const
+		if ($line =~ /(?:const\*|\*const)/) {
+			if (WARN("CONST_POINTER",
+				 "const pointers should have spaces around const\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\*const\b/* const/g;
+				$fixed[$fixlinenr] =~ s/\bconst\*/const */g;
+			}
+		}
+
 # check for non-global char *foo[] = {"bar", ...} declarations.
 		if ($line =~ /^.\s+(?:static\s+|const\s+)?char\s+\*\s*\w+\s*\[\s*\]\s*=\s*\{/) {
 			WARN("STATIC_CONST_CHAR_ARRAY",

