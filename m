Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC0E75477E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGOIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGOIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 04:31:23 -0400
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF3B1FC4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=rSSiVFk2v4n85VELba0fSAB2miODEOCh8vu6YfyysBk=;
        t=1689409882;x=1689499882; 
        b=vhXfydK1nVaPBs8AsisYbWlIEQlO6uoVfu7KFBT1HD4/EGWrRsTujohlRkUz4d6dL1E8kzTWVkJrH/Ivv3s9q3rkr1cl/owLZDyUrGDrbP2tI+M8/a4ehppaEaIrQcYVHmZBKc0gkCtrpOH9XdRpQPf0YQdbTImRVFShj/Bl3G93QkTlzuSahkKIF0SCHgUoP0OSSAw4BTtQn8GYmg+x3wYUc2dlv99GF0cwAFDFEFYFlxX2l3JV4BRxR6rN03L/UQboUxheiq0UI5AuDy+5YZ5qCLNnLeqzD21auoKYnxyn6ZE9xWAO7gC1lnS9ctC9pkFkuGPSkFgXwTRI0/wIaQ==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qKagR-0004Hr-Nd; Sat, 15 Jul 2023 11:31:20 +0300
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
        Linus Walleij <linus.walleij@linaro.org>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: simple-card-utils: introduce asoc_simple_parse_triggers()
Date:   Sat, 15 Jul 2023 11:30:42 +0300
Message-Id: <20230715083046.108674-2-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230715083046.108674-1-fido_max@inbox.ru>
References: <20230715083046.108674-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9A075ED63965291975FF12524F3FDD82B4E108C225E84807B182A05F538085040D6DDEE028965B4E2DB642822489F5C4D5C1AC8B4BDA17D09F7BE4CFDB6188BB4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7850A3F981F25E362EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AA63211222797374EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA26C057A3EA4EAC467209D804C2FA285220879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006379BABF3D50D9A3D87389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E7356C9A9530EBF72002C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5638CFA7C84DA4B80BBA65E42AFBF6689E5E046773473FECEF87CCE6106E1FC07E67D4AC08A07B9B05E59ED9F89912417C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF3FED46C3ACD6F73ED3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF51050EE56D8CBBCBE7D45992A0A709BE31F70C2EC6D00D2968BD5D16F18F8D59A7F6D8DEE3A50DD47BBDB0A562C82D59FB6E383D7E5F7F83F675BAD5E23DA4679AE72A77DD75ADD14C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojTPX5czuwuGGee9Ue/ogdxg==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B2828104ADCBB8D278B8F8B69AC493EC598CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
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

This function parses DT DAI link triggers params and assigns
the appropriate fields in struct snd_soc_dai_link.
It supports two triggers trigger-stop and trigger-start.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 include/sound/simple_card_utils.h     |  3 ++
 sound/soc/generic/simple-card-utils.c | 45 +++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index b450d5873227..ea8c17f7b280 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -180,6 +180,9 @@ int asoc_simple_parse_widgets(struct snd_soc_card *card,
 				      char *prefix);
 int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
 				   char *prefix);
+int asoc_simple_parse_triggers(struct device_node *node,
+			       char *prefix,
+			       struct snd_soc_dai_link *dai_link);
 
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 3019626b0592..58f5c672184a 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -737,6 +737,51 @@ int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_pin_switches);
 
+static enum snd_soc_trigger_order asoc_simple_parse_trigger(
+					struct device_node *node,
+					char *prefix,
+					char *trigger_name)
+{
+	enum snd_soc_trigger_order trigger = SND_SOC_TRIGGER_ORDER_DEFAULT;
+	struct {
+		char *name;
+		unsigned int val;
+	} of_trigger_table[] = {
+		{ "default",	SND_SOC_TRIGGER_ORDER_DEFAULT },
+		{ "ldc",	SND_SOC_TRIGGER_ORDER_LDC },
+	};
+	const char *str;
+	char prop[128];
+	int ret;
+
+	if (!prefix)
+		prefix = "";
+
+	snprintf(prop, sizeof(prop), "%s%s", prefix, trigger_name);
+
+	ret = of_property_read_string(node, prop, &str);
+	if (ret == 0) {
+		for (int i = 0; i < ARRAY_SIZE(of_trigger_table); i++) {
+			if (strcmp(str, of_trigger_table[i].name) == 0) {
+				trigger = of_trigger_table[i].val;
+				break;
+			}
+		}
+	}
+
+	return trigger;
+}
+
+int asoc_simple_parse_triggers(struct device_node *node,
+			       char *prefix,
+			       struct snd_soc_dai_link *dai_link)
+{
+	dai_link->trigger_stop = asoc_simple_parse_trigger(node, prefix, "trigger-stop");
+	dai_link->trigger_start = asoc_simple_parse_trigger(node, prefix, "trigger-start");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_parse_triggers);
+
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			  struct asoc_simple_jack *sjack,
 			  int is_hp, char *prefix,
-- 
2.40.1

