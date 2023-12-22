Return-Path: <linux-kernel+bounces-10066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA8C81CF73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B931C22700
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1F2EAE0;
	Fri, 22 Dec 2023 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XutJyryH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED062E82A;
	Fri, 22 Dec 2023 21:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8469C433C8;
	Fri, 22 Dec 2023 21:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703279983;
	bh=85pem+bV3h4CTSEJsl8gxNpUqeC+ByEZF8tHZajdLdo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XutJyryH1C0yuKZA/mta5BFslea1nPHuuMEMIqTexQjedrgggkrdf3eqN2kD6EkgU
	 3jCx87FzTjHItInuySR3YJOOZmFV211W9WBPfOQXj+lHVaF9uXE6yR6kBTdYnjJhdQ
	 s70fgyCI5FDyEx/7pzbczFpZNRK/qYjTXh+G6TNTSIAAXIHxfpWMzIAO4LYqjrX9U5
	 wAjkBSNhgkiJ/W8etslilyY1mQKWxdEWarTXXTaBT+uPKmD129ajAHNB4wLfI2NAKS
	 isigYPWU3YdtSbDmSciHfVtXZ1A1wrIOZH52LLSxoazUgCso3tswSPt13z5HfEGnjQ
	 qfE7JAi8wYz6Q==
Received: (nullmailer pid 2942328 invoked by uid 1000);
	Fri, 22 Dec 2023 21:19:39 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>, Usama Arif <usama.arif@bytedance.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com, Ashish Kalra <ashish.kalra@amd.com>, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>, pbonzini@redhat.com, Anthony Yznaga <anthony.yznaga@oracle.com>, arnd@arndb.de, linux-doc@vger.kernel.org, linux-mm@kvack.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-trace-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Rob Herring <robh+dt@kernel.org>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, James Gowans <jgowans@amazon.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20231222195144.24532-12-graf@amazon.com>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
Message-Id: <170327997978.2942294.14458926896132199704.robh@kernel.org>
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Date: Fri, 22 Dec 2023 15:19:39 -0600


On Fri, 22 Dec 2023 19:51:44 +0000, Alexander Graf wrote:
> With ftrace in KHO, we are creating an ABI between old kernel and new
> kernel about the state that they transfer. To ensure that we document
> that state and catch any breaking change, let's add its schema to the
> common devicetree bindings. This way, we can quickly reason about the
> state that gets passed.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  .../bindings/kho/ftrace/ftrace-array.yaml     | 46 +++++++++++++++
>  .../bindings/kho/ftrace/ftrace-cpu.yaml       | 56 +++++++++++++++++++
>  .../bindings/kho/ftrace/ftrace.yaml           | 48 ++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/kho/ftrace/ftrace-array.yaml:43:111: [warning] line too long (117 > 110 characters) (line-length)
./Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.yaml:53:111: [warning] line too long (117 > 110 characters) (line-length)
./Documentation/devicetree/bindings/kho/ftrace/ftrace.yaml:45:111: [warning] line too long (117 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-array.example.dts:29.25-39: Value 0x0000000101000000 truncated to 0x01000000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-array.example.dts:29.48-62: Value 0x0000000101000100 truncated to 0x01000100
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-array.example.dts:29.73-87: Value 0x0000000101000038 truncated to 0x01000038
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-array.example.dts:29.96-110: Value 0x0000000101002000 truncated to 0x01002000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.example.dts:29.25-39: Value 0x0000000101000000 truncated to 0x01000000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.example.dts:29.48-62: Value 0x0000000101000100 truncated to 0x01000100
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.example.dts:29.73-87: Value 0x0000000101000038 truncated to 0x01000038
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace-cpu.example.dts:29.96-110: Value 0x0000000101002000 truncated to 0x01002000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace.example.dts:29.25-39: Value 0x0000000101000000 truncated to 0x01000000
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace.example.dts:29.48-62: Value 0x0000000101000100 truncated to 0x01000100
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace.example.dts:29.73-87: Value 0x0000000101000038 truncated to 0x01000038
WARNING: Documentation/devicetree/bindings/kho/ftrace/ftrace.example.dts:29.96-110: Value 0x0000000101002000 truncated to 0x01002000

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231222195144.24532-12-graf@amazon.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


