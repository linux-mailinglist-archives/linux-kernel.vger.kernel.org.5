Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97805781BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjHTA3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjHTA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:28:36 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79B2F44F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 15:46:09 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSv3g75pLz47;
        Sun, 20 Aug 2023 00:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692485168; bh=7hzp2hc4e/TZs9fzafZjaaeRfA4qwEmZHAuIGv5yMyY=;
        h=Date:Subject:From:To:Cc:From;
        b=iDVNlBK+1H9P+oPYM41wjUaWQuF4Rp8MTib+j7YlC9jSpokLtxYtSgCDwbXUc89vT
         YeJOA2e4IoMeHLGiA/o+uF8Cx6iVOeHlofxmGSKV9v7yVrLtPlq4m8Z7GeFwDtMpZZ
         FLughktcPYPhQIwGNKZZs2lWLjDrAyQ+ahpN8nCcWegfoVGnqLuY7FfvnSpEoAcyf0
         cqqas5tO47V8zoCdR43D6qod87ssxmuo53/pXg/KxubctckczSPzxNikMmScfd9CDl
         0H5DU8Bal+naevTNyNk0wQW2GuK5/EmfzKmGS38jCh9mj9Qr9PSLI99BKGjlFYgpks
         5axLO9FJwGCgw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sun, 20 Aug 2023 00:46:07 +0200
Message-Id: <cover.1692484240.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/6] regulator: core: locking fixes and cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reduces regulator locking code complexity. The single fix is
more a cosmetic one as it applies to unexpected (WARN-generating) error
paths.

Michał Mirosław (6):
  regulator: core: simplify regulator_lock_nested()
  regulator: core: skip nesting lock for -EDEADLK
  regulator: core: simplify nested locking
  regulator: core: remove `goto`s from resolve_supply()
  regulator: core: propagate error out ouf regulator_lock_two()
  regulator: core: simplify lock_two()

 drivers/regulator/core.c | 110 +++++++++++++++------------------------
 1 file changed, 42 insertions(+), 68 deletions(-)

-- 
2.39.2

