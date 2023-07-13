Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BE8752B16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGMTkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjGMTkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:40:05 -0400
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97193269D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/DXal/wo7zy1AjG8Ahf9bA6hGj4RtAqyE9mspEBjTSg=;
        t=1689277201;x=1689367201; 
        b=Jk6VTb+FnRZSha7/+Pwy0800C+DvQ9ntViBCK/wf9IRMCyGi8UGEf1D0N7CvArAkOnf+4SLctgzcH6M28YyEi13/t5GgVkOxSPJpL3Rjuvwvcvq+5E6Lk2vliztGXI5eBWE2Ewyw0xj7kA9kM7AqeM2bNFbQP0fpRMWCykXrGyMIRObItfoRUClclZHHD/9HEFVK+RE2oL15cqKnMi6pj9GGR6iDhBG+6V9LqXQILqJddvfTEIaHpRAwpxK0Bmks4bhqXm5vvrtOgzawkx4SAH7kX20It8QtEFDObvNiAR+NTLtVXO1ivD08/aoMSbVjKF+ufJ1UsQLcPkVr3PFuOg==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qK2AP-0006Hf-3t; Thu, 13 Jul 2023 22:39:57 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     alsa-devel@alsa-project.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Astrid Rost <astrid.rost@axis.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: simple-card: add trigger-stop entry parser
Date:   Thu, 13 Jul 2023 22:39:04 +0300
Message-Id: <20230713193905.347588-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9B2A9E02D3479B2E06768B938AD40B0B2F406FBBAB3BE9D72182A05F5380850406DC6D14D925A779A2119D8C4AF091899F639B471B5C538B71F2A1A2D3236EA0E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77E5C269A77776DF2EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637838376990962B7D5EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBADC8D9AFB7B321797B82816B4024C712C20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0A633E4711A430BBE8941B15DA834481FA18204E546F3947C21E93C0F2A571C7BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F3DB775AA22245C5389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735D2D576BCF940C736C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A52ACD4640EF4E2DF5F78C217658B4B12B8FC51247452AE7A5F87CCE6106E1FC07E67D4AC08A07B9B04CB6874B0BCFF0B89C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF45476691863E33E2B04F67E6343802320863C8822840C2802C193F750F709F6742A4A3B3B141354E7BBDB0A562C82D59E571549C58EB79DA3D12F54DD51D984D21BEC6C0C71ED4F84C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojmIyQFW4pVcmSCfdzvUtIhQ==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986BEFD39F4E0CD76037CBD1B963389C487698CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may be useful to specify trigger-stop for some DMA-based simple
audio card. So add this "trigger-stop" device tree entry parser.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 sound/soc/generic/simple-card.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index a78babf44f38..86df7d326068 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -145,8 +145,27 @@ static int simple_parse_node(struct asoc_simple_priv *priv,
 	struct snd_soc_dai_link_component *dlc;
 	struct asoc_simple_dai *dai;
 	int ret;
+	const char *str;
+	struct {
+		char *name;
+		unsigned int val;
+	} of_trigger_table[] = {
+		{ "default",	SND_SOC_TRIGGER_ORDER_DEFAULT },
+		{ "ldc",	SND_SOC_TRIGGER_ORDER_LDC },
+	};
+
 
 	if (cpu) {
+		ret = of_property_read_string(np, "trigger-stop", &str);
+		if (ret == 0) {
+			for (int i = 0; i < ARRAY_SIZE(of_trigger_table); i++) {
+				if (strcmp(str, of_trigger_table[i].name) == 0) {
+					dai_link->trigger_stop = of_trigger_table[i].val;
+					break;
+				}
+			}
+		}
+
 		dlc = asoc_link_to_cpu(dai_link, 0);
 		dai = simple_props_to_dai_cpu(dai_props, 0);
 	} else {
-- 
2.40.1

