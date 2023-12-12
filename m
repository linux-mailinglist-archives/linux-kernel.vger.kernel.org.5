Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5180E444
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjLLGaN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 01:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLGaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:30:11 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51AFEA;
        Mon, 11 Dec 2023 22:30:17 -0800 (PST)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 18D8AC08D4;
        Tue, 12 Dec 2023 06:30:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 77F9A32;
        Tue, 12 Dec 2023 06:30:13 +0000 (UTC)
Message-ID: <f03d372a282712dee8412e47aff9bb54f181efd9.camel@perches.com>
Subject: Re: [PATCH v3] iio: sx9324: avoid copying property strings
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Mon, 11 Dec 2023 22:30:12 -0800
In-Reply-To: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
References: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: phty865o753pcccfgobmbjixq886ngut
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 77F9A32
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19KB/KFUBqn8Mv2AYKskQceelw0LpRgeF8=
X-HE-Tag: 1702362613-104366
X-HE-Meta: U2FsdGVkX1/Rm4DJ1kl4WgyqfPYbh3ciIzLs0+/i1MmIHs710d6iZ3iVuY2VSxAN51cu5/6F8ymqllhraoJox4+clD3FQTrULWI8Jis3sEu4Ok5I163X9ZvBX+O5mq8bq0E0z1XQhwKuPg4xT9Xg++Wb/uLzuxn9qZeFi6zJLJD6dKoq9K9m4V0zFgqHdt1Dn67J1smEJnBCU0bhRTWGB0ExvHozZdCsk9v6pVBlobrOC8RnMzgdtwQVfiRdiklTsdCXCkhGQa1/+QEemCB7SoAfquPUR6O+fFi0QS6wleZFHQHkaPQXuGNJCI3TTm2e
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 00:42 +0000, Justin Stitt wrote:
> We're doing some needless string copies when trying to assign the proper
> `prop` string. We can make `prop` a const char* and simply assign to
> string literals.

trivia:

I would have updated it like this moving the
various declarations into the case blocks
where they are used and removing a few unused
#defines

---
 drivers/iio/proximity/sx9324.c | 69 +++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index ac2ed2da21ccc..c50c1108a69cc 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -877,17 +877,8 @@ static const struct sx_common_reg_default *
 sx9324_get_default_reg(struct device *dev, int idx,
 		       struct sx_common_reg_default *reg_def)
 {
-	static const char * const sx9324_rints[] = { "lowest", "low", "high",
-		"highest" };
-	static const char * const sx9324_csidle[] = { "hi-z", "hi-z", "gnd",
-		"vdd" };
-#define SX9324_PIN_DEF "semtech,ph0-pin"
-#define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
-#define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
-	unsigned int pin_defs[SX9324_NUM_PINS];
-	char prop[] = SX9324_PROXRAW_DEF;
-	u32 start = 0, raw = 0, pos = 0;
-	int ret, count, ph, pin;
+	u32 raw = 0;
+	int ret;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
 
@@ -896,7 +887,13 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_AFE_PH0:
 	case SX9324_REG_AFE_PH1:
 	case SX9324_REG_AFE_PH2:
-	case SX9324_REG_AFE_PH3:
+	case SX9324_REG_AFE_PH3: {
+		unsigned int pin_defs[SX9324_NUM_PINS];
+		int count;
+		int pin;
+		int ph;
+		char prop[32];
+
 		ph = reg_def->reg - SX9324_REG_AFE_PH0;
 		snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
 
@@ -913,7 +910,15 @@ sx9324_get_default_reg(struct device *dev, int idx,
 			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
 		reg_def->def = raw;
 		break;
-	case SX9324_REG_AFE_CTRL0:
+	}
+	case SX9324_REG_AFE_CTRL0: {
+		static const char * const sx9324_csidle[] = {
+			"hi-z", "hi-z", "gnd", "vdd"
+		};
+		static const char * const sx9324_rints[] = {
+			"lowest", "low", "high", "highest"
+		};
+
 		ret = device_property_match_property_string(dev, "semtech,cs-idle-sleep",
 							    sx9324_csidle,
 							    ARRAY_SIZE(sx9324_csidle));
@@ -930,16 +935,17 @@ sx9324_get_default_reg(struct device *dev, int idx,
 			reg_def->def |= ret << SX9324_REG_AFE_CTRL0_RINT_SHIFT;
 		}
 		break;
+	}
 	case SX9324_REG_AFE_CTRL4:
-	case SX9324_REG_AFE_CTRL7:
+	case SX9324_REG_AFE_CTRL7: {
+		const char *type;
+
 		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
-			strncpy(prop, "semtech,ph01-resolution",
-				ARRAY_SIZE(prop));
+			type = "semtech,ph01-resolution";
 		else
-			strncpy(prop, "semtech,ph23-resolution",
-				ARRAY_SIZE(prop));
+			type = "semtech,ph23-resolution";
 
-		ret = device_property_read_u32(dev, prop, &raw);
+		ret = device_property_read_u32(dev, type, &raw);
 		if (ret)
 			break;
 
@@ -949,6 +955,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
 					   raw);
 		break;
+	}
 	case SX9324_REG_AFE_CTRL8:
 		ret = device_property_read_u32(dev,
 				"semtech,input-precharge-resistor-ohms",
@@ -982,17 +989,21 @@ sx9324_get_default_reg(struct device *dev, int idx,
 					   6 + raw * (raw + 3) / 2);
 		break;
 
-	case SX9324_REG_ADV_CTRL5:
+	case SX9324_REG_ADV_CTRL5: {
+		u32 start = 0;
+
 		ret = device_property_read_u32(dev, "semtech,startup-sensor",
 					       &start);
 		if (ret)
 			break;
-
 		reg_def->def &= ~SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK;
 		reg_def->def |= FIELD_PREP(SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK,
 					   start);
 		break;
-	case SX9324_REG_PROX_CTRL4:
+	}
+	case SX9324_REG_PROX_CTRL4: {
+		u32 pos = 0;
+
 		ret = device_property_read_u32(dev, "semtech,avg-pos-strength",
 					       &pos);
 		if (ret)
@@ -1005,15 +1016,16 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		reg_def->def |= FIELD_PREP(SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK,
 					   raw);
 		break;
+	}
 	case SX9324_REG_PROX_CTRL0:
-	case SX9324_REG_PROX_CTRL1:
+	case SX9324_REG_PROX_CTRL1: {
+		const char *type;
+
 		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
-			strncpy(prop, "semtech,ph01-proxraw-strength",
-				ARRAY_SIZE(prop));
+			type = "semtech,ph01-proxraw-strength";
 		else
-			strncpy(prop, "semtech,ph23-proxraw-strength",
-				ARRAY_SIZE(prop));
-		ret = device_property_read_u32(dev, prop, &raw);
+			type = "semtech,ph23-proxraw-strength";
+		ret = device_property_read_u32(dev, type, &raw);
 		if (ret)
 			break;
 
@@ -1022,6 +1034,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
 					   raw);
 		break;
 	}
+	}
 	return reg_def;
 }
 

