Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EBB7E16F1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjKEVzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjKEVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:55:41 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 13:55:37 PST
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CBBF;
        Sun,  5 Nov 2023 13:55:37 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 280C348025C;
        Sun,  5 Nov 2023 16:49:20 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1699220960;
 h=message-id : date : mime-version : to : from : subject :
 content-type : content-transfer-encoding : from;
 bh=w846FgME/jEcSJRPkUT+ZucoFM06xqBTLPlRyUMyt8s=;
 b=hn0HvWaq6dUgP+jUeAGCetMpGQoPmkBxxAEWWEgtpxD79Vfe0CxpavryroBU9zMGZuH8M
 lJCs5aEsNn56GoKDQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1699220960;
        cv=none; b=Ztn1KmpLgJwq3NohB8Rt0r2DUJ8I+AhHQZPZBMERcwUPFtai2R3sCrzye6mubAn6j45UI/XB+oM/4pzzKkEFhAfDYynb4yMSu8pEzMe8+MC2hy5fv0HYXehWU2fUyQX/tHLAn/xYueQkHZqedF8OQxqNzZiKUIeAYkmvQpf5Ba4yrpHoWmkkKodQxRn758cKIc0fQnUq7xqOjvwV7TrKoQiTK4g63ZdFn7Sf8iptzJGn10LyO/yXAE8L/G4O8bYY4KbzqTc3pJFJYtNkFTMuPJqkK3v3v3zK4qsvhiS/hEQ1r5PDZszn4ozCkuXQDGPUICyJ7B5r18+GayUSz0S56A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1699220960; c=relaxed/simple;
        bh=ea3jR6zDLYnVl7gOllMac0LjYLqs6vkRIFyTtg7L8Do=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Content-Language:To:From:Subject:Content-Type:
         Content-Transfer-Encoding; b=WPM0QxcMzrziTFBmETOdXnEEfgm+CIBfRf9V4ydnGlUVygH8J5pmv6GHL1thmvpg5LWKnxhxtN+88PAVs/88+HUy+m+nOlLPbruNYnPDy1WB57d3MZm0fADeiOBK99CWqpgzp5zBSLxo9w+YOmzG0gsOX2fqqGdy4AbRENG0g+8AQ/zmMy5Ilfl2y7K0ApQhZkFEmrwvfTviEzWaynwV2bjH92QWWGdm5dY2JHvvaXTP2vXusPuRFklon1fKQVQv7+fRTP+2f4zRz+aMZP/aFPlIzYefwiziSSl+2QZkR87F1HFE9e1+5/Y37nXKbcIFfNrEmBjjS5i67PrekUZzsA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1699220960;
 h=message-id : date : mime-version : to : from : subject :
 content-type : content-transfer-encoding : from;
 bh=w846FgME/jEcSJRPkUT+ZucoFM06xqBTLPlRyUMyt8s=;
 b=A/BLgfPuXDptzdPMLpdKBWrtsFISvHhe1YDsTtPW7cNzzJu+hOb2wOeEFaiq4QrYR5emt
 59Fon2rspHZIAeevUE7kEcrCQxjOBg76pjQZ8Wse9lWTaQn57WliMnYrrLAPOJHc+LJFdgC
 tmKk+9iHnVbCU6jqQIpe6q52KHm9c3xRBkQ+rxBml5LI5mAFLy5w0sRA+cojD6v5KSBJf7b
 7MyMGNrAbF+4nXJEcEayFspAnuFZ4zI3Gc+x1NGjCZFlcxFSFgmuTDCdFNe/h1NLsnw0LSY
 GwRC067BT1yb0UeKagnT+4BR68MJ8j/MlaFqhdnQ+TbG1tFQCcuD47NSQpvQ==
Message-ID: <be576842-6ad5-43f8-abcf-bd7fa84e235d@sapience.com>
Date:   Sun, 5 Nov 2023 16:49:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, keyrings@vger.kernel.org
From:   Genes Lists <lists@sapience.com>
Subject: Hash sha3-512 vs scripts/sign-file vs openssl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainline modules signing supports sha3-xxx.

However, unless I'm doing something wonky, signing fails and it appears 
to come from scripts/sign-file failing in CMS_add1_signer() :

  At main.c:321:
- SSL error:2EFFF06F:CMS routines:CRYPTO_internal:ctrl failure: 
cms/cms_sd.c:269

openssl version here on arch is 3.1.4 and this may quite possibly be 
related to the following issue with sha3 and ecdsa, but not clear to me.

   https://github.com/openssl/openssl/pull/22147

regards,

gene

