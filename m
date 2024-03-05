Return-Path: <linux-kernel+bounces-93046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB9D872A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99532889D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FB12D1EC;
	Tue,  5 Mar 2024 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jziuSI6U"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701012D202;
	Tue,  5 Mar 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677165; cv=fail; b=UQ3Wt/HrCy02j3YmE4eAajTzNTj0ShUXnPURu4uCB8TFa4gztmqAIyRxM9125sR16o6xC5HmrX6JSyXtMr1H1dFPvw6VemKGxP+2WXXX34nba0Q2ikRtzwi481rTwbMvzJuBaQ1Lhly0XWZ/Go+rIPt/eFndhxor4Phg0LIGrvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677165; c=relaxed/simple;
	bh=lQe/Fm6PgMomyf2JLYC4Hh6faokLZm/mD4OIQZpAAhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXY93Ed2rmEHFAoN2PaTDA9u3a1sXbY4PakPua9NybqlfgDYYfJ+6dyxWcOq45afV4ctCE0wXuZakzhcMcN1aU8MRZtdnQKsL2bW9ZpGH0dBf+43HwdTyFQNs2EXkeKV73dTfMr0oROWiFyYdX+9nuP93MZSQaaZXrbuJxKkpdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jziuSI6U; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJQnIhJ1k9LniBhqBuNa3B7yzG/Z7sq9viTEPtwxiozGp2rOouEp26XjoLL+YiIY3AkTMgYWVQSOFlLUworLWrkWPsl89k4xaBawvNWe9a/z/5SuZi2sB5xd8Y00jkwuzRqeuEX6vBt5NOfjRw/QXh26Iz2V1uEZrGaayWiWCMzCc0PL4BFoQ+n2cpSteZIqOjNT3PIxt0dgQC8TNU8/CO6vJYtNWvpU80cIj+LylGcLzokpsP/7Z/22T5Mn5Mirw08F3z3rkKJUdwbhWhZ6zSi5LI22aYzpREUuBzeh9wc3Wy96+WnbiJdRspp4aKxodTVDXdnCzdT/c2DcP1bVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0mXncK8z3pOLU7AvOXJs9Kr+lxZXPU0W+f0wdz1Tzo=;
 b=LLsq8qnU/GBcw+M2D9d+W+80PbWvot4+o/2GEP/D/t7TAyHCJEURj2aCW6hNaj481v71AxB/53rfsMqdWYPKuUoPTDrN/VH4C3FuLvsb04g/hUYSPo5T5oElgyrpLr8HIb96jQm3pBwbaZEhFcKhQxNmtJgWH1DcYS6nQfenTRGduo5r8CChLHTYhG2xVAYg1SfHpO4RzGKuHaST17kCB8KXoDLx+fk+B5CyQkbpLkTCu1HpJtl4yDeDZUVlAtpcxV81sEQJPaSUikUUEoeo3WZ+f5haIVB0+YtoDAZ4wbLTrtW4PD0Kd1IxTZg1Em59oiPfN8Aoqz99zy51WM6zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0mXncK8z3pOLU7AvOXJs9Kr+lxZXPU0W+f0wdz1Tzo=;
 b=jziuSI6UOdjCjttxxru4M2O2fdsey1jfv1y804cYCQSaNbj566eAMlpSJ0pTbV/1/YLAjdr7na1XyB3fVGTeaWMyQezZOKchuLwE5iOTUjhq3EFZUQEBHzppLH9PQSggX5vLM1pjBOsZZ+k21sreiY+yKxzEBOJnoZkuhU3kDxY=
Received: from CH5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610:1f0::10)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 22:19:20 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::32) by CH5PR05CA0012.outlook.office365.com
 (2603:10b6:610:1f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 22:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 22:19:20 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 16:19:17 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <carlos.bilbao@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadnaik@amd.com>
Subject: [PATCH 3/4] docs/sp_SP: Add translation of process/1.Intro.rst
Date: Tue, 5 Mar 2024 16:18:38 -0600
Message-ID: <20240305221839.2764380-4-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305221839.2764380-1-avadhut.naik@amd.com>
References: <20240305221839.2764380-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b6d90e-1552-4194-9b89-08dc3d624e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k/eTAuWHMTvfk/aXS/yLvwTBs4ye3h9tM5RKoiTmz+NEGYlYVkugyjlC1RZdbRBBds4FFGjM256KyGCYeHmCi6NzPAVAExWsNQ6tvE9O3OZ36rsk6XtGrSJOAGj5o46rXS2x8XHnzTIkpj49rNtSOkz4KNdqAbdfZ4gWxxkFdAEw6Nofl1U5XFGO25LPXAtgu3Z9U15m3pGMC1y7DaxEUvrS1WnhXcbAdPPKINbU9zEp+ALT0L1FNxLs2kA4I9i5wJ4yeobUAx0nxrtZnbiCogJor7Ig3Y3J9D9VsztP+ZoZxdjXV/9OB/k9J2UYYZL42SMNzSF1CLUq4XsnqmMMOw/frWZWH59xrsYNm9KYhaHIffw/HgXxZ4HOvfe+0CbRdgGDtEXHRlgXpA9h3jZLEx3JAfSpEZKRMDqlc0dJ9iX9mv48diRZlyp9OtJDZxO3fYSzVSWrDanCkwDziup6W1jpaWnZLRtFBDqJt4oglnSI/wZ29UGsIJZcCLe8eULlKw0rGSFbdg2ZfMzDuXBoFwwodhK0i1wIvloWQSr4zOyX/X05O8x0yn+ZHwLTf0gp+CwCZTRkFsp/BOsxE2n+knikUdAKrjbvwRiVdQPYV+fFoarb69qRG6681nYrZZqJK6so0DxHnK9nGJjOHfTD4YvXUXOSIMV1NE8FAwcync+Y3EMEUy9qplsgHigdOE6htVGS2DM07UIvcCNWfsBqgjrILLgsMP2OECXUL9ARx9Ro1QOtqni9RwVb3Knwl2pQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:es;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 22:19:20.6188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b6d90e-1552-4194-9b89-08dc3d624e23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

Translate Documentation/process/1.Intro.rst into Spanish

In order to avoid broken links in the translated document, empty files
have been created for documents which have not yet been translated.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 .../translations/sp_SP/process/1.Intro.rst    | 302 ++++++++++++++++++
 .../translations/sp_SP/process/2.Process.rst  |  11 +
 .../sp_SP/process/3.Early-stage.rst           |  11 +
 .../translations/sp_SP/process/4.Coding.rst   |  11 +
 .../translations/sp_SP/process/5.Posting.rst  |  11 +
 .../sp_SP/process/6.Followthrough.rst         |  11 +
 .../sp_SP/process/7.AdvancedTopics.rst        |  11 +
 .../sp_SP/process/8.Conclusion.rst            |  11 +
 .../sp_SP/process/development-process.rst     |   2 +
 9 files changed, 381 insertions(+)
 create mode 100644 Documentation/translations/sp_SP/process/1.Intro.rst
 create mode 100644 Documentation/translations/sp_SP/process/2.Process.rst
 create mode 100644 Documentation/translations/sp_SP/process/3.Early-stage.rst
 create mode 100644 Documentation/translations/sp_SP/process/4.Coding.rst
 create mode 100644 Documentation/translations/sp_SP/process/5.Posting.rst
 create mode 100644 Documentation/translations/sp_SP/process/6.Followthrough.rst
 create mode 100644 Documentation/translations/sp_SP/process/7.AdvancedTopics.rst
 create mode 100644 Documentation/translations/sp_SP/process/8.Conclusion.rst

diff --git a/Documentation/translations/sp_SP/process/1.Intro.rst b/Documentation/translations/sp_SP/process/1.Intro.rst
new file mode 100644
index 000000000000..9b92b6c85221
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/1.Intro.rst
@@ -0,0 +1,302 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/1.Intro.rst
+:Translator: Avadhut Naik <avadhut.naik@amd.com>
+
+.. _sp_development_process_intro:
+
+Introducción
+============
+
+Resumen ejecutivo
+-----------------
+
+El resto de esta sección cubre el alcance del proceso de desarrollo del
+kernel y los tipos de frustraciones que los desarrolladores y sus
+empleadores pueden encontrar allí. Hay muchas razones por las que el
+código del kernel debe fusionarse con el kernel oficial (“mainline”),
+incluyendo la disponibilidad automática para los usuarios, el apoyo de la
+comunidad en muchas formas, y la capacidad de influir en la dirección del
+desarrollo del kernel. El código contribuido al kernel de Linux debe
+estar disponible bajo una licencia compatible con GPL.
+
+:ref:`sp_development_process` introduce el proceso de desarrollo, el ciclo
+de lanzamiento del kernel y la mecánica de la "ventana de combinación"
+(merge window). Se cubren las distintas fases en el desarrollo del parche,
+la revisión y, el ciclo de fusión. Hay algunas discusiones sobre
+herramientas y listas de correo. Se anima a los desarrolladores que deseen
+comenzar con el desarrollo del kernel a encontrar y corregir errores como
+ejercicio inicial.
+
+:ref:`sp_development_early_stage` cubre la planificación de proyectos en
+etapas tempranas, con énfasis en involucrar a la comunidad de desarrollo
+lo antes posible.
+
+:ref:`sp_development_coding` trata sobre el proceso de codificación. Se
+discuten varios escollos encontrados por otros desarrolladores. Se cubren
+algunos requisitos para los parches, y hay una introducción a algunas de
+las herramientas que pueden ayudar a garantizar que los parches del kernel
+sean correctos.
+
+:ref:`sp_development_posting` trata sobre el proceso de enviar parches para
+su revisión. Para ser tomados en serio por la comunidad de desarrollo,
+los parches deben estar correctamente formateados y descritos, y deben
+enviarse al lugar correcto. Seguir los consejos de esta sección debería
+ayudar a garantizar la mejor recepción posible para su trabajo.
+
+:ref:`sp_development_followthrough` cubre lo que sucede después de publicar
+parches; el trabajo está lejos de terminar en ese momento. Trabajar con
+revisores es una parte crucial del proceso de desarrollo; esta sección
+ofrece varios consejos sobre cómo evitar problemas en esta importante
+etapa. Se advierte a los desarrolladores que no asuman que el trabajo está
+terminado cuando un parche se fusiona en mainline.
+
+:ref:`sp_development_advancedtopics` introduce un par de temas “avanzados”:
+la administración de parches con git y la revisión de parches publicados
+por otros.
+
+:ref:`sp_development_conclusion` concluye el documento con punteros a las
+fuentes para obtener más información sobre el desarrollo del kernel.
+
+De qué trata este documento
+---------------------------
+
+El kernel de Linux, con más de 8 millones de líneas de código y más de
+1000 colaboradores en cada versión, en uno de los proyectos de software
+libre más grandes y activos que existen. Desde sus humildes comienzos en
+1991, este kernel ha evolucionado hasta convertirse en el mejor componente
+del sistema operativo que se ejecuta en reproductores de música digital
+de bolsillo, PC de escritorio, las supercomputadoras más grandes que
+existen y todo tipo de sistemas intermedios. Es una solución robusta,
+eficiente, y escalable para casi cualquier situación.
+
+Con el crecimiento de Linux, ha llegado un aumento en el número de
+desarrolladores (y empresas) que desean participar en su desarrollo. Los
+vendedores de hardware quieren asegurarse de que Linux sea compatible con
+sus productos, lo que hace que esos productos sean atractivos para los
+usuarios de Linux. Los vendedores de sistemas embebidos, que utilizan
+Linux como componente de un producto integrado, quieren que Linux sea lo
+más capaz y adecuado posible para tarea en cuestión. Los distribuidores
+y otros vendedores de software que basan sus productos en Linux tienen un
+claro interés en las capacidades, el rendimiento, y la fiabilidad del
+kernel de Linux. Y los usuarios finales, también, a menudo desearán
+cambiar Linux para que se adapte mejor a sus necesidades.
+
+Una de las características más convincentes de Linux es que es accesible
+a estos desarrolladores; cualquier persona con las habilidades necesarias
+puede mejorar Linux e influir en la dirección de su desarrollo. Los
+productos propietarios no pueden ofrecer este tipo de apertura, que es una
+característica del proceso de software libre. Pero, en todo caso, el
+kernel es aún más libre que la mayoría de los otros proyectos de software
+libre. Un ciclo típico de desarrollo de kernel de tres meses puede
+involucrar a más de 1000 desarrolladores que trabajan para más de 100
+empresas diferentes (o sin pertenecer a ninguna empresa).
+
+Trabajar con la comunidad de desarrollo del kernel no es especialmente
+difícil. Pero, a pesar de eso, muchos colaboradores potenciales han
+experimentado dificultades al tratar de hacer el trabajo del kernel. La
+comunidad del kernel ha desarrollado sus propias formas distintivas de
+operar, lo que le permite funcionar de manera fluida (y producir un
+producto de alta calidad) en un entorno donde miles de líneas de código
+se cambian todos los días. Por lo tanto, no es sorprendente que el
+proceso de desarrollo del kernel de Linux difiera mucho de los métodos de
+desarrollo propietarios.
+
+El proceso de desarrollo del kernel puede parecer extraño e intimidante
+para los nuevos desarrolladores, pero hay buenas razones y una sólida
+experiencia detrás de él. Un desarrollador que no entienda las formas de
+la comunidad del kernel (o, peor aún, que intente burlarse o eludirlas)
+tendrá una experiencia frustrante por delante. La comunidad de
+desarrollo, si bien es servicial para aquellos que están tratando de
+aprender, tiene poco tiempo para aquellos que no escuchan o que no se
+preocupan por el proceso de desarrollo.
+
+Se espera que quienes lean este documento puedan evitar esa experiencia
+frustrante. Hay mucho material aquí, pero el esfuerzo que implica leerlo
+será recompensado en poco tiempo. La comunidad de desarrollo siempre
+necesita desarrolladores que ayudan a mejorar el kernel; el siguiente
+texto debería ayudarle – o a quienes trabajan para usted, a unirse a
+nuestra comunidad.
+
+Créditos
+--------
+
+Este documento fue escrito por Jonathan Corbet, corbet@lwn.net. Ha sido
+mejorado por los comentarios de Johannes Berg, James Berry, Alex Chiang,
+Roland Dreier, Randy Dunlap, Jake Edge, Jiri Kosina, Matt Mackall, Arthur
+Marsh, Amanda McPherson, Andrew Morton, Andrew Price, Tsugikazu Shibata y
+Jochen Voß.
+Este trabajo fue respaldado por la Fundación Linux; gracias especialmente
+a Amanda McPherson, quien reconoció el valor de este esfuerzo e hizo que
+todo sucediera.
+
+Importancia de integrar el código en el mainline
+------------------------------------------------
+
+Algunas empresas y desarrolladores ocasionalmente se preguntan por qué
+deberían molestarse en aprender cómo trabajar con la comunidad del
+kernel y obtener su código en el kernel mainline (el “mainline” es el
+kernel mantenido por Linus Torvalds y utilizado como base por los
+distribuidores de Linux. A corto plazo, contribuir con código puede
+parecer un gasto evitable; parece más fácil mantener el código separado
+y dar soporte a los usuarios directamente. La verdad del asunto es que
+mantener el código separado (“fuera del árbol”) es pan para hoy y hambre
+para mañana.
+
+Para ilustrar los costos del código fuera-del-árbol, aquí hay algunos
+aspectos relevantes del proceso de desarrollo del kernel. La mayoría de
+estos se discutirán con mayor detalle más adelante en este documento.
+Considerar:
+
+- El código que se ha fusionado con el kernel mainline está disponible
+  para todos los usuarios de Linux. Estará presente automáticamente en
+  todas las distribuciones que lo habiliten. No hay necesidad de discos
+  de controladores, descargas, o las molestias de admitir múltiples
+  versiones de múltiples distribuciones; todo simplemente funciona, para
+  el desarrollador y para el usuario. La incorporación al mainline
+  resuelve un gran número de problemas de distribución y soporte.
+
+- Mientras los desarrolladores del kernel se esfuerzan por mantener una
+  interfaz estable para el espacio de usuario, la API interna de kernel
+  está en constante cambio. La falta de una interfaz interna estable es
+  una decisión deliberada de diseño; permite realizar mejoras
+  fundamentales en cualquier momento y da como resultado un código de
+  mayor calidad. Pero uno resultado de esa política es que cualquier
+  código fuera-del-árbol requiere un mantenimiento constante si va a
+  funcionar con los nuevos kernels. Mantener el código fuera-del-árbol
+  requiere una cantidad significativa de trabajo sólo para que ese código
+  siga funcionando.
+
+  En su lugar, el código en el mainline no requiere este trabajo como
+  resultado de una regla simple que requiere que cualquier desarrollador
+  que realice un cambio en la API también corrija cualquier código que
+  se rompa como resultado de ese cambio. Así que, el código fusionado en
+  el mainline tiene costos de mantenimiento significativamente más bajos.
+
+- Más allá de eso, el código que está en el kernel a menudo será
+  mejorado por otros desarrolladores. Resultados sorprendentes pueden
+  provenir de capacitar a su comunidad de usuarios y clientes para mejorar
+  su producto.
+
+- El código del kernel se somete a revisión, tanto antes como después
+  de fusionarse con el mainline. No importa cuán fuertes sean las
+  habilidades del desarrollador original, este proceso de revisión
+  invariablemente encuentra formas en las que se puede mejorar el código.
+  A menudo la revisión encuentra errores graves y problemas de seguridad.
+  Esto es especialmente cierto para el código que se ha desarrollado en
+  un entorno cerrado; dicho código se beneficia fuertemente de la
+  revisión por desarrolladores externos. El código fuera-del-árbol es
+  de menor calidad.
+
+- La participación en el proceso de desarrollo es su manera de influir en
+  la dirección del desarrollo del kernel. Los usuarios que se quejan
+  desde el sofa son escuchados, pero los desarrolladores activos tienen
+  una voz más fuerte – y la capacidad de implementar cambios que hacen
+  que el kernel funcione mejor para sus necesidades.
+
+- Cuando el código se mantiene por separado, siempre existe la posibilidad
+  de que un tercero contribuya a una implementación diferente de una
+  característica similar. Si eso sucede, conseguir que su código
+  fusionado será mucho más difícil – hasta el punto de la imposibilidad.
+  Entonces se enfrentará a las desagradables alternativas de (1) mantener
+  una característica no estándar fuera del árbol indefinidamente, o
+  (2) abandonar su código y migrar sus usuarios a la versión en el árbol.
+
+- La contribución del código es la acción fundamental que hace que todo
+  el proceso funcione. Al contribuir con su código, puede agregar nuevas
+  funcionalidades al kernel y proporcionar capacidades y ejemplos que son
+  útiles para otros desarrolladores del kernel. Si ha desarrollado código
+  para Linux (o está pensando en hacerlo), claramente tiene un interés
+  en el éxito continuo de esta plataforma; contribuir con código es una
+  de las mejores maneras de ayudar a garantizar ese éxito.
+
+Todo el razonamiento anterior se aplica a cualquier código de kernel
+fuera-del-árbol, incluido el código que se distribuye en forma propietaria
+y únicamente en binario. Sin embargo, hay factores adicionales que deben
+tenerse en cuenta antes de considerar cualquier tipo de distribución de
+código de kernel únicamente en binario. Estos incluyen:
+
+- Las cuestiones legales en torno a la distribución de módulos
+  propietarios del kernel son, en el mejor de los casos, confusas;
+  bastantes titulares de derechos de autor del kernel creen que la
+  mayoría de los módulos binarios son productos derivados del kernel y
+  que, como resultado, su distribución es una violación de la licencia
+  Pública General de GNU (sobre la que se dirá más adelante). El autor
+  de este texto no es abogado, y nada en este documento puede considerarse
+  asesoramiento legal. Solo los tribunales pueden determinar el verdadero
+  estatus legal de los módulos de código cerrado. Pero la incertidumbre
+  que acecha a esos módulos está ahí a pesar de todo.
+
+- Los módulos binarios aumentan enormemente la dificultad de depurar
+  problemas del kernel, hasta el punto de que la mayoría de los
+  desarrolladores del kernel ni siquiera lo intentarán. Por lo tanto,
+  la distribución de módulos únicamente en binario hará que sea más
+  difícil para sus usuarios obtener soporte de la comunidad.
+
+- El soporte también es más difícil para los distribuidores de módulos
+  únicamente en binario, que deben proporcionar una versión del módulo
+  para cada distribución y cada versión del kernel que deseen apoyar.
+  Podría requerir docenas de compilaciones de un solo módulo para
+  proporcionar una cobertura razonablemente completa, y sus usuarios
+  tendrán que actualizar su módulo por separado cada vez que
+  actualicen su kernel.
+
+- Todo lo que se dijo anteriormente sobre la revisión de código se aplica
+  doblemente al código cerrado. Dado que este código no está disponible
+  en absoluto, no puede haber sido revisado por la comunidad y, sin duda,
+  tendrá serios problemas.
+
+Los fabricantes de sistemas embebidos, en particular, pueden verse
+tentados a ignorar gran parte de lo que se ha dicho en esta sección
+creyendo que están enviando un producto autónomo que utiliza una
+versión de kernel congelada y no requiere más desarrollo después de su
+lanzamiento. Este argumento desaprovecha el valor de la revisión
+generalizad del código y el valor de permitir que sus usuarios agreguen
+capacidades a su producto. Pero estos productos también tienen una vida
+comercial limitada, después de la cual se debe lanzar una nueva versión.
+En ese punto, los vendedores cuyo código esté en el mainline y bien
+mantenido estarán en una posición mucho mejor para preparar el nuevo
+producto rápidamente para el mercado.
+
+Licencias
+---------
+
+El código se contribuye al kernel de Linux bajo varias licencias, pero
+todo el código debe ser compatible con la versión 2 de la Licencia
+Pública General de GNU (GPLv2), que cubre la distribución del kernel. En
+la práctica, esto significa que todas las contribuciones de código están
+cubiertas ya sea por la GPLv2 (con, opcionalmente, un lenguaje que permite
+la distribución en versiones posteriores de la GPL) o por la licencia BSD
+de tres cláusulas. Cualquier contribución que no esté cubierta por una
+licencia compatible no será aceptada en el kernel.
+
+No se requieren (ni se solicitan) cesiones de derechos de autor para el
+código aportado al kernel. Todo el código fusionado en el kernel
+mainline conserva su propiedad original; como resultado, el kernel ahora
+tiene miles de propietarios.
+
+Una implicación de esta estructura de propiedad es que cualquier intento
+de cambiar la licencia del kernel está condenado a un fracaso casi seguro.
+Hay pocos escenarios prácticos en los que se pueda obtener el acuerdo de
+todos los titulares de derechos de autor (o eliminar su código del
+kernel). Así que, en particular, no hay perspectivas de una migración a
+la versión 3 de la GPL en un futuro previsible.
+
+Es imperativo que todo el código aportado al kernel sea legítimamente
+software libre. Por esa razón, no se aceptará código de colaboradores
+anónimos (o seudónimos). Todos los colaboradores están obligados a
+“firmar” su código, indicando que el código puede ser distribuido con
+el kernel bajo la GPL. El código que no ha sido licenciado como software
+libre por su propietario, o que corre el riesgo de crear problemas
+relacionadas con los derechos de autor para el kernel (como el código que
+se deriva de esfuerzos de ingeniería inversa que carecen de las garantías
+adecuadas) no puede ser contribuido.
+
+Las preguntas sobre cuestiones relacionadas con los derechos de autor son
+comunes en las listas de correo de desarrollo de Linux. Normalmente, estas
+preguntas no recibirán escasez de respuestas, pero se debe tener en cuenta
+que las personas que responden a esas preguntas no son abogados y no
+pueden proporcionar consejo legal. Si tiene preguntas legales relacionadas
+con el código fuente de Linux, no hay sustituto para hablar con un abogado
+que entienda este campo. Confiar en las respuestas obtenidas en listas
+técnicas de correo es un asunto arriesgado.
diff --git a/Documentation/translations/sp_SP/process/2.Process.rst b/Documentation/translations/sp_SP/process/2.Process.rst
new file mode 100644
index 000000000000..768c43dfd805
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/2.Process.rst
@@ -0,0 +1,11 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/2.Process.rst
+
+.. _sp_development_process:
+
+Cómo funciona el proceso de desarrollo
+======================================
+
+.. warning::
+	TODO aún no traducido
diff --git a/Documentation/translations/sp_SP/process/3.Early-stage.rst b/Documentation/translations/sp_SP/process/3.Early-stage.rst
new file mode 100644
index 000000000000..71cfb3fb0fda
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/3.Early-stage.rst
@@ -0,0 +1,11 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/3.Early-stage.rst
+
+.. _sp_development_early_stage:
+
+Planificación en etapa inicial
+==============================
+
+.. warning::
+	TODO aún no traducido
diff --git a/Documentation/translations/sp_SP/process/4.Coding.rst b/Documentation/translations/sp_SP/process/4.Coding.rst
new file mode 100644
index 000000000000..d9436e039b4b
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/4.Coding.rst
@@ -0,0 +1,11 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/4.Coding.rst
+
+.. _sp_development_coding:
+
+Conseguir el código correcto
+============================
+
+.. warning::
+	TODO aún no traducido
diff --git a/Documentation/translations/sp_SP/process/5.Posting.rst b/Documentation/translations/sp_SP/process/5.Posting.rst
new file mode 100644
index 000000000000..50a3bc5998a8
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/5.Posting.rst
@@ -0,0 +1,11 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/5.Posting.rst
+
+.. _sp_development_posting:
+
+Publicar parches
+================
+
+.. warning::
+	TODO aún no traducido
diff --git a/Documentation/translations/sp_SP/process/6.Followthrough.rst b/Documentation/translations/sp_SP/process/6.Followthrough.rst
new file mode 100644
index 000000000000..f0acf9082bb3
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/6.Followthrough.rst
@@ -0,0 +1,11 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/6.Followthrough.rst
+
+.. _sp_development_followthrough:
+
+Seguimiento
+===========
+
+.. warning::
+	TODO aún no traducido
diff --git a/Documentation/translations/sp_SP/process/7.AdvancedTopics.rst b/Documentation/translations/sp_SP/process/7.AdvancedTopics.rst
new file mode 100644
index 000000000000..553759857339
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/7.AdvancedTopics.rst
@@ -0,0 +1,11 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/7.AdvancedTopics.rst
+
+.. _sp_development_advancedtopics:
+
+Temas avanzados
+===============
+
+.. warning::
+	TODO aún no traducido
diff --git a/Documentation/translations/sp_SP/process/8.Conclusion.rst b/Documentation/translations/sp_SP/process/8.Conclusion.rst
new file mode 100644
index 000000000000..dd181cb8ec9a
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/8.Conclusion.rst
@@ -0,0 +1,11 @@
+.. include:: ../disclaimer-sp.rst
+
+:Original: Documentation/process/8.Conclusion.rst
+
+.. _sp_development_conclusion:
+
+Para más información
+====================
+
+.. warning::
+	TODO aún no traducido
diff --git a/Documentation/translations/sp_SP/process/development-process.rst b/Documentation/translations/sp_SP/process/development-process.rst
index 41616249aa9e..17fb168418ac 100644
--- a/Documentation/translations/sp_SP/process/development-process.rst
+++ b/Documentation/translations/sp_SP/process/development-process.rst
@@ -22,3 +22,5 @@ para entenderla.
    :caption: Contenido
    :numbered:
    :maxdepth: 2
+
+   1.Intro
-- 
2.34.1


