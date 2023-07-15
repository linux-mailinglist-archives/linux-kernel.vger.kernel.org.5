Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E475477D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGOIbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 04:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGOIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:31:22 -0400
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6391FC4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=ZKhzLWNdmjBtXOIYVhIiLNkh0JEdBAqRw0U5lWWzcuw=;
        t=1689409879;x=1689499879; 
        b=IBWdEtlKoHnk8+bmTKyckdv8JcHjy/Yqe1QwKgRcSjR3SwDuZrTP4m6KqGWKYzkceXsDdzALi33PlhbfOvT3c62+dM3JJU2lVQFd5Ft14o3iRMB/TPL9cE0XooSGDe2zNmdzfsJTRIbgwaa8P+pH8fl7oHkJCgBUv+2cd56QKEsT+XA+tD8W3AKYYDD9tK097DpeNTphiokN0iweK2yTkvMUbjCgmiOnFQcz1shsFE6jevD9Y4s6dOzWegr+L69mmOmIjdVWnVZDnLUwG/FmQVCiJ6egNsZ0zPx5ELOi5nEwahZ16LVVmVKhsC1vH5MlCJaTbQSFZSZiYv0tTc2jlg==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qKagL-0004Hr-Br; Sat, 15 Jul 2023 11:31:13 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     alsa-devel@alsa-project.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Robert Hancock <robert.hancock@calian.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Add support for trigger-start/stop for simple audio card
Date:   Sat, 15 Jul 2023 11:30:41 +0300
Message-Id: <20230715083046.108674-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD97569A0FE902DCB3DF525A235365A19A2D5B01E069C4E5BA91867C24CE74E72BB5FE18E9CBFBE7C0789144A87CC8DB7C17741EAF50AA9EC464F43132855423BE32D5CFE12AD13DA04
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7811C3E343B302E2EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637560334CFC131571A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C6C034DDD1D4E83DCBF9D4AB7B00C4A66F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE78A0F7C24A37A3D769FA2833FD35BB23D9E625A9149C048EEB1593CA6EC85F86DF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006378E5B25976F539216389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E7356C9A9530EBF72002C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A54BD09D3D82926D4CBBA65E42AFBF6689543138F5BAE7995DF87CCE6106E1FC07E67D4AC08A07B9B067F1C1C3ABB44F3A9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A09062BEEFFB5F8EA3ECB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFEB9499EF466856B8C130459DFA7FA73FF68ECA639735B8C8B6C51BC92C112E7DF964158C91B2A10B7BBDB0A562C82D59FB6E383D7E417F8377BBFEC008046DDF9AE72A77DD75ADD14C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojTPX5czuwuGFIk79KwLFaKg==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B81FD16BFA2D1134FC40072ADED85A44798CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for trigger-start/stop for simple audio card.

Maxim Kochetkov (3):
  ASoC: simple-card-utils: introduce asoc_simple_parse_triggers()
  ASoC: dt-bindings: simple-card: add triggers properties
  ASoC: simple-card: add triggers parsing from DT node support

 .../bindings/sound/simple-card.yaml           | 31 +++++++++++++
 include/sound/simple_card_utils.h             |  3 ++
 sound/soc/generic/simple-card-utils.c         | 45 +++++++++++++++++++
 sound/soc/generic/simple-card.c               |  4 ++
 4 files changed, 83 insertions(+)

-- 
2.40.1

