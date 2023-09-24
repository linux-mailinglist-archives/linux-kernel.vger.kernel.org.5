Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE27AC608
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 02:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjIXAlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 20:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXAlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 20:41:21 -0400
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F3FA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 17:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:
        Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description
        :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E077wAdyEkVySS1+LXo/H+AZNFp/cAK0I9hfQH/1Dmc=; b=bfedigwJ9dJryvC4sxxFFrruxQ
        UOiofSrSMVdXPlnjBepLh3H6VOO+KwQglGV/5VOxNXVfH+eWgCJ+kON0tlwvmf7lsaTKJPI0nbbmD
        Wo/BBRhvWlq9TiEC9e9TZkgdwDNxgCDditCaJ53zTQgfCIoDUvERXrOV3UdkPK1pDQJWMnODNccm+
        7WDwMLtnTdBAr9i7tSlOgIxE0WkSgRrWqTbXgj52Etmjy0JKnkJzY9q3/wq4cOdscVtzSXyRUVngK
        HiE8TcxifIB5wmGw6pQtu3Q1W4lLHHmNeujcWy9WSChZyZCElKns30wvHxOdPc/wfBsqFEC7vSfvN
        yR6nmSOg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
        (envelope-from <dg@treblig.org>)
        id 1qkDBL-0018ci-19;
        Sun, 24 Sep 2023 00:41:07 +0000
Date:   Sun, 24 Sep 2023 00:41:07 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     matthew.brost@intel.com, mgreer@animalcreek.com,
        krzysztof.kozlowski@linaro.org
Cc:     linux-kernel@vger.kernel.org, airlied@gmail.com,
        intel-gfx@lists.freedesktop.org
Subject: ERR_PTR(0) in a couple of places
Message-ID: <ZQ+Fo9WKyGphwI8R@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-12-amd64 (x86_64)
X-Uptime: 00:32:50 up 8 days,  3:31,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I randomly noticed there are a couple of places in the kernel that
do
   ERR_PTR(0);

and thought that was odd - shouldn't those just be NULL's ?

1) i915
  drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c : 47

    if (i <= 1)
      return ERR_PTR(0);

  from f9d72092cb490 

2) trf7970a
  drivers/nfc/trf7970a.c : 896

      trf->ignore_timeout =
         !cancel_delayed_work(&trf->timeout_work);
      trf->rx_skb = ERR_PTR(0);
      trf7970a_send_upstream(trf);

   from 1961843ceeca0

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
