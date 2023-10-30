Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCD87DBC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjJ3PbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjJ3PbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:31:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06409C9;
        Mon, 30 Oct 2023 08:31:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso7804062a12.3;
        Mon, 30 Oct 2023 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698679860; x=1699284660; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OwEL6Pg+GghxIBTWLg7sNVv9RjmOZEAEG7bBzkZXR7g=;
        b=EVEDM77gRD/J82tHhTVAt8AC9BcvlPT0H9Tnp+5FBeeXkVb84ebjVyCMLASxN5hxzG
         b5J32MB/SqxFYfkJ1kkCsU/0rhIditGfLEyVjI+rMpE6kcXJ4zzJmvZgmjVRytXzH3FB
         e0N22jPvUpjbTMprvKm0QdpvDwOmR7nHrsleGX9x0JXUjFoyZ3DcaUkfnznv8o0e6QlH
         ZGGYbvZxt8xbYOk5Bl3AXTSavLsxlLGB3d0+eK3TfJqXSBCF/DvngBHpEx017aPIbK56
         qtzXgu6W/1qQlZ2x+Mr1eoEZfdtfF2KmWMTAHdETzVea3GGxCYRHzfGzJUD4QHHrH6nH
         cmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698679860; x=1699284660;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwEL6Pg+GghxIBTWLg7sNVv9RjmOZEAEG7bBzkZXR7g=;
        b=uUkAPUC/TadKpHvlnMZs+xRL2MhBMT3SZS86LN06OhK80b83z1BqLJHyJnp7CcDnu+
         M2xL9Uxi0tB/KmCCRWPYRZG9R67gkAZPDtwvHHqumSX+zm6dWHAHnseaqpW+iJUBfWPX
         JQ1thtgqC39fNfWr87FeisqtObTDhB+lHrybkr8Wvr9ZwE7+aNXhKCA77xsDXH48MUSe
         OXN2U22/pm/FKwF6gLalNGByXF5QcNCelmUJmdzifgehYzp+ZC01mykY+RLj+BObUERa
         5XRweQxlB8qLvsoO7CE6d6dgtT9tVvPyQRnGQtvsB631K18L+Wk06h+nCVQ82pf6/9Db
         silw==
X-Gm-Message-State: AOJu0YwP9NQT2isZtTRJkokeaq63eBuh/FwiX9DpqC86TuqCu3MUAX1S
        e0pkLB/FXwrHv/iQpCSqj4M=
X-Google-Smtp-Source: AGHT+IG9pPQq9f7S7tZBTZOUFwtWw3/Nj1u7nONKa0vBEqjmp+oqajxd/j3IOP8Fo2JfnZ1SGfxFyA==
X-Received: by 2002:a17:906:2b55:b0:9d2:810f:4922 with SMTP id b21-20020a1709062b5500b009d2810f4922mr3407648ejg.33.1698679860170;
        Mon, 30 Oct 2023 08:31:00 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090613ca00b00992b8d56f3asm6172905ejc.105.2023.10.30.08.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:30:59 -0700 (PDT)
Date:   Mon, 30 Oct 2023 17:30:57 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231030153057.3ofydbzh7q2um3os@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
 <20231030152325.qdpvv4nbczhal35c@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030152325.qdpvv4nbczhal35c@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:23:25PM +0200, Vladimir Oltean wrote:
> On Mon, Oct 30, 2023 at 03:37:24PM +0100, Linus Walleij wrote:
> > On Mon, Oct 30, 2023 at 3:16 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > 
> > > Could you please try to revert the effect of commit 339133f6c318 ("net:
> > > dsa: tag_rtl4_a: Drop bit 9 from egress frames") by setting that bit in
> > > the egress tag again? Who knows, maybe it is the bit which tells the
> > > switch to bypass the forwarding process.
> > 
> > I have already tried that, it was one of the first things I tried,
> > just looking over the git log and looking for usual suspects.
> > 
> > Sadly it has no effect whatsoever, the problem persists :(
> > 
> > > Or maybe there is a bit in a
> > > different position which does this. You could try to fill in all bits in
> > > unknown positions, check that there are no regressions with packet sizes
> > > < 1496, and then see if that made any changes to packet sizes >= 1496.
> > > If it did, try to see which bit made the difference.
> > 
> > Hehe now we're talking :D
> > 
> > I did something similar before, I think just switching a different bit
> > every 10 packets or so and running a persistent ping until it succeeds
> > or not.
> > 
> > I'll see what I can come up with.
> > 
> > Yours,
> > Linus Walleij
> 
> And the drop reason in ethtool -S also stays unchanged despite all the
> extra bits set in the tag? It still behaves as if the packet goes
> through the forwarding path?

Could you please place these skb_dump() calls before and after the magic
__skb_put_padto() call, for us to see if anything unexpected changes?
Maybe the socket buffers have some unusual geometry which the conduit
interface doesn't like, for some reason.

The number of skb dumps that you provide back should be even, and
ideally the first one should be the unaltered packet, to avoid confusion :)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index 25238093686c..2ca189b5125e 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -41,18 +41,22 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 	u8 *tag;
 	u16 out;
 
-	/* Pad out to at least 60 bytes */
-	if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
-		return NULL;
-
 	/* Packets over 1496 bytes get dropped unless they get padded
 	 * out to 1518 bytes. 1496 is ETH_DATA_LEN - tag which is hardly
 	 * a coinicidence, and 1518 is ETH_FRAME_LEN + FCS so we define
 	 * the threshold size and padding like this.
 	 */
 	if (skb->len >= (ETH_DATA_LEN - RTL4_A_HDR_LEN)) {
+		skb_dump(KERN_ERR, skb, true);
+
 		if (unlikely(__skb_put_padto(skb, ETH_FRAME_LEN + ETH_FCS_LEN, false)))
 			return NULL;
+
+		skb_dump(KERN_ERR, skb, true);
+	} else {
+		/* Pad out to at least 60 bytes */
+		if (unlikely(__skb_put_padto(skb, ETH_ZLEN, false)))
+			return NULL;
 	}
 
 	netdev_dbg(dev, "add realtek tag to package to port %d\n",
-- 
2.34.1

