Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB207A2789
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjIOUAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjIOT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:59:49 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EA92703
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:59:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c44a25bd0bso2621505ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694807981; x=1695412781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QTAaYbGChQLUY+Gq2za7n5ZQvKf3nOru5ieThOaDQg=;
        b=isc2Uoq/XYyn9PkkBGKy5qP6NPWyEYQbN8EYstt+PwKCqEUdunW6rNMEvxBUyI5e4S
         UYMM/jbKgUGyDFZp2hAlfnPFaOn/6Tltpq3FIeNJiYC7woXA1qOyib9CzjWAVQ1BY8pp
         7wh3TXjiLcnXBOcg6LKtDHfqbRwqFrp3U2A6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807981; x=1695412781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QTAaYbGChQLUY+Gq2za7n5ZQvKf3nOru5ieThOaDQg=;
        b=FJaIvxQ6h1Y8/UU9S4+ttSvlMm6DU5pNVSxlTT8uRotVSSDP9y109Eq+xWUC/zf6ui
         SOaeM2wsXw7vFxIgm9rmM7aGaqGhVaoEyD4PChy6HMqp+3HXJ4EGhGDVnd/Qx5g5l68M
         blQoQuQUXCoVAEsb+2p1hLvxMVh9uPiZwibJHRRpjgv+sedHPD7AlazcF/h+/53nnw3K
         aKyGSiln0/V8L/ajbrdVeVssD3D6tIqWNnK1QjQvSxOMntewapo61PwxQRcKjvktxgjK
         Gw1uJXrgdnXpNkc8ppZD5ZNogcomwgvEcwlUEEI5y7GOG5Z+xkv+3lDtHyz9urTs9/Ac
         gE4Q==
X-Gm-Message-State: AOJu0YzqtSei6N5NmoHlfBFzlPLdFd6abOAOrareli4g67bMdeWqYVfI
        D/pIkwf0sW/CFKAlrtPyJIWJdA==
X-Google-Smtp-Source: AGHT+IGYK7Py8XcBgcsBTxZTMvjHQKfVzB5OmfXsKXYmjNSdHYAcwM38OH4ue55Hb1gXlpvUJ8KkHA==
X-Received: by 2002:a17:902:684d:b0:1bc:224a:45c2 with SMTP id f13-20020a170902684d00b001bc224a45c2mr6041713pln.15.1694807981241;
        Fri, 15 Sep 2023 12:59:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902a40400b001c407fac227sm3855508plq.41.2023.09.15.12.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:59:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        John Keeping <john@keeping.me.uk>,
        Peter Chen <peter.chen@nxp.com>,
        Hulk Robot <hulkci@huawei.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Will McVicker <willmcvicker@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-usb@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] usb: gadget: f_midi: Annotate struct f_midi with __counted_by
Date:   Fri, 15 Sep 2023 12:59:39 -0700
Message-Id: <20230915195938.never.611-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=keescook@chromium.org;
 h=from:subject:message-id; bh=7ll080Ip8+xgpFyr1ptkCSq6rEkEIYaf1ZtwJzLxEFA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLeqiItMEXLkRQ6I0AgJamBwTNeEi20eegnZt
 l84WwSJaiuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS3qgAKCRCJcvTf3G3A
 Jt0FD/4xkc6NwN+7lXbDMSm4p836lNJxBBL+/SGvtbx8Eh9D5gW27FBIx1e3Y+W0R7/CiQnJdvC
 Q0numJF5+tgUVzR5ef5AIRZRrSuQC1OovDPs0lOar9jswym6HioJEY29phkpX8u8B/dQJiazIP4
 OgoHGhaj8mVg/fbTbFi0RfyeScciuvBKdwKTrcL+u2O9Tjbaquwjg0L4J2t+Ka0fFW0yDuzyI4M
 WtPAW1i5V9KEz0XTxGtMfAb966wgcc1cOszoqiNMSb4qro2RjomQLIBffiFL2UVCAHhDvlI0aRU
 RrduhXmOJx0e+KPtPV9mgpJPinw8+MTo55974325aOLst/tii0/RrCvsEnedJK2bqy7COveWb00
 VjG2aP6iHIx2TJ1slgBO+TecF1NeAe9eCOz/s/TkFOSaYfmUVVs3ZJ/5tmjoYzHXQfifjId8O8k
 uxMMrDXmPYIBDXNP8sHd4zMHzHvRdAiL3T7Fh8kI7mPFYdfobFOfVqNA0hYZVf8TxBRv/egZR7t
 k+NrSD3agAofKIDkcP9tEe/EqkDU0PgsMMCOEXysbZlXE87+k/nwnpGzH6hQr55vHTCKUL9L8SE
 zBX5jFgLgc7kB2SpvHWvj9WL1+Kg1t7LcDQvmyAeh4rZkXnSkvDtNhlJUP5LZPS/Bcm29gzBplo
 V2HLJoI /9JPsM2g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct f_midi.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Keeping <john@keeping.me.uk>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: Hulk Robot <hulkci@huawei.com>
Cc: Allen Pais <allen.lkml@gmail.com>
Cc: Will McVicker <willmcvicker@google.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Zhang Qilong <zhangqilong3@huawei.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/gadget/function/f_midi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 2d02f25f9597..033e347554db 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -99,7 +99,7 @@ struct f_midi {
 	unsigned int in_last_port;
 	unsigned char free_ref;
 
-	struct gmidi_in_port	in_ports_array[/* in_ports */];
+	struct gmidi_in_port	in_ports_array[] __counted_by(in_ports);
 };
 
 static inline struct f_midi *func_to_midi(struct usb_function *f)
@@ -1349,6 +1349,7 @@ static struct usb_function *f_midi_alloc(struct usb_function_instance *fi)
 		status = -ENOMEM;
 		goto setup_fail;
 	}
+	midi->in_ports = opts->in_ports;
 
 	for (i = 0; i < opts->in_ports; i++)
 		midi->in_ports_array[i].cable = i;
@@ -1359,7 +1360,6 @@ static struct usb_function *f_midi_alloc(struct usb_function_instance *fi)
 		status = -ENOMEM;
 		goto midi_free;
 	}
-	midi->in_ports = opts->in_ports;
 	midi->out_ports = opts->out_ports;
 	midi->index = opts->index;
 	midi->buflen = opts->buflen;
-- 
2.34.1

