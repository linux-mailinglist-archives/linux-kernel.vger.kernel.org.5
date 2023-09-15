Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABFD7A1B70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjIOJ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjIOJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:56:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C601720
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:56:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a9f139cd94so260479866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771770; x=1695376570; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWUTTgPAUvTLzKrLP6oc3d68vCkhgUGZ2fi5Q9n95I4=;
        b=WowTx6jZZo3Ve9HkV6smrhkacANuBZvPpHBEHmEH7eMzDtvJh1HCEUQcBY/H8PtTSH
         OO30c6jYWc3kLvkruHmSsyGkiT8zuR0dZRIebHSlH1UuFm2bN6fV9H7Sx3Dej9KBXkZd
         jTzNXAfREkkCygD6AJqB36SRbKM8uuXyjtw4S2nBT39JYRefm7HuDyLFYHglr1u/MZz4
         MZBKpwbyZE71C9iaoW9U1a69YoTpw2oEuja3Y9IEI7kY3+HDoSoTw1jben+pT7+IZWqw
         6iAwaV7AWv5SIE8uWsDwxNAi9gsWafgC3titOgyB4GjiWMSnb6NJvmr4J1wAcqH8RjTa
         IujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771770; x=1695376570;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWUTTgPAUvTLzKrLP6oc3d68vCkhgUGZ2fi5Q9n95I4=;
        b=hV4yrP+3by8F+JxcuNgzprKK2csrhMze0ncaz/KzsdOG8BB1BUwEWfsyiSsApaCMxR
         yyVLkmx4oFntD7z3s4EEtfGt8Y4iqYzqukYwO9vgt1ovrOWdYIs/OcexzdBDPTuoQl06
         1QmqDeaD2/f1Usng79d0i4//Pv7QpkntpyVzpbtdXWY3GbTm06dFGcOy0BkTF2SsS7xT
         Plg1eF1lRK6Sf5wd22U8WrCh9W6/yv2120E+2pk5lSNbyxyDEXlxCKdS6XCotU0Pwd/h
         nxgrqFhhyzXe9cK1FvL/g14QtXneBXnY1UB8pPCnpfzBFz0vr/PwPRfXn7rH1J8Bndbk
         VFiQ==
X-Gm-Message-State: AOJu0YwsBd/xtu+uFF1nrMxwnOkPq59EwhWKgrA/ZkHOt40AcQSIDb3y
        fJYLrQv+m7MleoICLGirrg==
X-Google-Smtp-Source: AGHT+IGDZdeqezQk1Ohs3mpZafErlVEnOZCGz8SeYJgeR9MQ0KpdK0T15IX6J26xAkcezJ+yHQL5Sw==
X-Received: by 2002:a17:906:3112:b0:9a5:a701:2b90 with SMTP id 18-20020a170906311200b009a5a7012b90mr993708ejx.40.1694771769552;
        Fri, 15 Sep 2023 02:56:09 -0700 (PDT)
Received: from p183 ([46.53.253.54])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906080a00b00997d76981e0sm2180256ejd.208.2023.09.15.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:56:08 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:56:07 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Subject: Buggy __free(kfree) usage pattern already in tree
Message-ID: <07c32bf1-6c1a-49d9-b97d-f0ae4a2b42ab@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__free() got some usage and some of the usage is buggy:

   832  static struct fwnode_handle *
   833  gpio_sim_make_bank_swnode(struct gpio_sim_bank *bank,
   834                            struct fwnode_handle *parent)
   835  {
   838          char **line_names __free(kfree) = NULL;
		// returns NULL or ERR_PTR(-E)
   848          line_names = gpio_sim_make_line_names(bank, &line_names_size);
   849          if (IS_ERR(line_names))
   850                  return ERR_CAST(line_names);


This pattern will result in calling kfree() on error value.
And there are no compiler or sparse checking these things.

This test module demonstrates the landmine:

[  812.981089] ------------[ cut here ]------------
[  812.981597] WARNING: CPU: 0 PID: 1326 at mm/slab_common.c:991 free_large_kmalloc+0x50/0x80
[  813.013266] ---[ end trace 0000000000000000 ]---
[  813.013800] object pointer: 0xfffffffffffffff4

#include <linux/module.h>
#include <linux/slab.h>
#include <linux/cleanup.h>

struct S {
	int x;
};

static struct S* f(void)
{
	struct S* s = kmalloc(sizeof(struct S), GFP_KERNEL);
	s = NULL;
	return s ?: ERR_PTR(-ENOMEM);
}

static int __init xxx_module_init(void)
{
	struct S *s __free(kfree) = NULL;
	s = f();
	if (IS_ERR(s)) {
		return PTR_ERR(s);
	}
	return 0;
}

static void __exit xxx_module_exit(void)
{
}
module_init(xxx_module_init);
module_exit(xxx_module_exit);
MODULE_LICENSE("GPL");
