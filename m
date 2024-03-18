Return-Path: <linux-kernel+bounces-105869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DBD87E5BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0734F1F22694
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92182C68C;
	Mon, 18 Mar 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyKpNz69"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751222C1AF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753968; cv=none; b=BU6naKX+1AmfqD8QnxfGPFldm/AA5oj6wYmDIBBehasZG+6lHQ9jJN0ZAbvznmSRUxKLNnpZeIwUwtE7mmdCPdwyWiuU00svwXtxxYHOzpAwIVdhXg6eVm1pZ4RBeCRWwlf1hYJ40BmmoxKfmMPUNxOmSLAOcuWf+tWSJEvvqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753968; c=relaxed/simple;
	bh=8y4vSdVUZCk+aPZhva5pLco3uG5l2lCYnp2HRRGYbkg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SPjZdz/Wj924JZIPnEJusMAFFCktB29QJA5hxMiO6wLDA4jlVACxSvBTpS87vilZHpSosnKOMTWjjI2fAnO9m+eAYBPR2bcGF4YI7HacBXcTje9O7EnNO1R3gzP3rVztNMy3dNTIDmJfCQi821aQXWkboovAU3FBHy3/sK5PuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tyKpNz69; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d4515aca90so251999e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710753965; x=1711358765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dr558Gtc+rRfkIYnJ72l9uUtS+S0kUdV5Cm0VXr/mqc=;
        b=tyKpNz69GkAF/dxzi9qfLSPyLCVErblaF4Nkwhl3t+ipwJzq8rtnLlv1GqG4PJ/lpJ
         JzcXZmvwtynAJeth3rowcHafUj+P4xEGKufFbSRqtuQ5P3Wo7Pl4sv1IhaIYW6yUtdCm
         jqbfRkY2CJUhav0KD0h4juyF0YhmITziNU3P1abs+dbZaE5VlNkOA7mQVSObs1RD7ooh
         V9Bd/dr/UgyQej7koeQXPdZB0uiU1TTDXgD0ewCNTfQuu4tAbu/VRkoJ6b6wA5a4XPOd
         Ntrc+j9SAtGSCL/7TwA+q/Wjr+dzIi9oZIm+loICzM3OpNpO1cHsXWrML36lN9HaFcPr
         49hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753965; x=1711358765;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dr558Gtc+rRfkIYnJ72l9uUtS+S0kUdV5Cm0VXr/mqc=;
        b=EyDJvoTOUg6HW5RLPIaibca41hbmYpTcshy6OF9q+tLtkV9WE1e0zfn6LBZyaDSwKv
         yAuEppJvKdrbDRIvkr7NYAGDXIepYNCRdhydh8zjL9ge0gBwNyraY8Phgveen9/sM4cV
         FqqFskxFCGZt68DW9Rf6E7y6xy/G7igXVLAFw2JQw/GbCsU63Vu6WrWInnVounsjg+jx
         BKh+5JA+SpBNF/XD2nm6xEuBMexql0D8AplJYtMiOh/2AknqoOqlmvjRZTRHnCfEY9nv
         BgZGOh2Km3NewakxwuxAgtbjEhjuj/jizmgUn2ycBbnFA/d0w1bFh6DY6mgIbPx06EXF
         NQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXqhted8jhHOvsXtTQGlp9vrmpKVNl/iOvE57lh+t1gY2gOijjplUs6xTsm7hsdiCO2yZ9i764b2HbaSLFcC4NK3xhJOu1dMuDR25Xp
X-Gm-Message-State: AOJu0YzzxLa1EPJhEARUo+dutFlemCk7QHwTFQsuzxPQOuuV0zNw+f4X
	totpVXI9ITWb1BSexlZ/Eo3vX3pAvoLnUicUcg5u6Rn0DkpadwLb0SomQMtKCBkfz/7ubWobar5
	NuWjDLOo0VEpVZxACpZcXkyvtiD5JRjCqH/SiFA==
X-Google-Smtp-Source: AGHT+IFDDQIlK3lVhoDg3KpbK/eh3Hhxm8PIDTagoTjsDxY8wbny4dXn7KvLQWqbF5dW8Rr0jLCdFvvcFrJRC5YENVg=
X-Received: by 2002:a1f:724c:0:b0:4ca:615e:1b61 with SMTP id
 n73-20020a1f724c000000b004ca615e1b61mr7860598vkc.10.1710753965337; Mon, 18
 Mar 2024 02:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 18 Mar 2024 14:55:54 +0530
Message-ID: <CA+G9fYs=OTKAZS6g1P1Ewadfr0qoe6LgOVSohqkXmFXotEODdg@mail.gmail.com>
Subject: net/sunrpc/sched.c: error: result of comparison against a string
 literal is unspecified (use an explicit string comparison function instead)
To: Netdev <netdev@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Nathan Chancellor <nathan@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on x86 kselftests build with
clang nightly  / clang-17 on Linux  next tag next-20240318.

This build config is generated from kselftest merge configs [1].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----------
In file included from net/sunrpc/sched.c:31:
In file included from include/trace/events/sunrpc.h:2524:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:419:
include/trace/events/sunrpc.h:707:4: error: result of comparison
against a string literal is unspecified (use an explicit string
comparison function instead) [-Werror,-Wstring-compare]
  667 |                         __assign_str(progname,
      |                         ~~~~~~~~~~~~~~~~~~~~~~
  668 |                                      task->tk_client->cl_program->name);
      |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  669 |                         __entry->version = task->tk_client->cl_vers;
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  670 |                         __assign_str(procedure,
task->tk_msg.rpc_proc->p_name);
      |

[1] steps to reproduce:
-----------
tuxmake --runtime podman --target-arch x86_64 --toolchain
clang-nightly --kconfig
https://storage.tuxsuite.com/public/linaro/lkft/builds/2dqIWv3Qq5qYmJfnmKfkSg9fvN0/config
LLVM=1 LLVM_IAS=1 debugkernel cpupower headers kernel kselftest
modules


Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dqIWv3Qq5qYmJfnmKfkSg9fvN0/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240318/testrun/23069554/suite/build/test/clang-nightly-lkftconfig-kselftest/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240318/testrun/23069554/suite/build/test/clang-nightly-lkftconfig-kselftest/details/


--
Linaro LKFT
https://lkft.linaro.org

